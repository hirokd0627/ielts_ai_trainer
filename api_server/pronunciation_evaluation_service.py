import os
import tempfile
import string
import threading
import json
import difflib
import pathlib
import shutil

from flask import Flask, Request
import azure.cognitiveservices.speech as speechsdk
from streaming_form_data import StreamingFormDataParser
from streaming_form_data.targets import FileTarget, ValueTarget
from settings import settings


class PronunciationEvaluationService:
    """A service class to evaluate user's pronunciation using Azure Speech Servcie."""

    def __init__(self, app: Flask):
        self._logger = app.logger
        self._end_event = threading.Event()

    def evaluate_pronunciation(self, request: Request):
        """Evaluate pronunciation for Speaking parts.

        Ref. This method is inspired by the following code.
        https://github.com/Azure-Samples/cognitive-services-speech-sdk/blob/85b9f88daa79730a20b0501622e16515e73e4d74/scenarios/python/console/language-learning/pronunciation_assessment.py#L229

        Args:
            request: Flask request object.

        Returns:
            Evaluation components:
                - fluency_score (float): Fluency score.
                - pronunciation_score (float): Pronunciation score.
        """
        try:
            # Create temporary .wav file.
            f = tempfile.NamedTemporaryFile(delete=True, suffix=".wav")
            tmp_path = f.name

            # Ref. https://github.com/siddhantgoel/streaming-form-data
            script_target = ValueTarget()
            lang_target = ValueTarget()
            audio_file_target = FileTarget(tmp_path)

            parser = StreamingFormDataParser(headers=request.headers)
            parser.register("script", script_target)
            parser.register("lang", lang_target)
            parser.register("audio_data", audio_file_target)

            # Read data through stream.
            byte_len = 4096  # 4096 bytes
            while True:
                chunk = request.stream.read(byte_len)
                if not chunk:
                    break
                parser.data_received(chunk)

            audio_file_target.on_finish()

            script = script_target.value.decode("utf-8")
            lang = lang_target.value.decode("utf-8")

            result = self._get_score_using_azure_speech_service(
                lang, script, tmp_path
            )

            # Log
            file_size = os.path.getsize(tmp_path)
            log_line = """
========================================
Pronunciation Evaluation
- script: {}
- lang: {}
- audio_data: size={}
- fluency_score": {}
- pronunciation_score": {}
- accuracy_score": {}
- completeness_score": {}
========================================
""".format(
                script,
                lang,
                file_size,
                result["fluency_score"],
                result["pronunciation_score"],
                result["accuracy_score"],
                result["completeness_score"],
            )
            self._logger.debug(log_line)

            if settings.debug:
                # Save received file to test
                self._copy_audio_file(tmp_path)

        finally:
            # tmp file is deleted here.
            f.close()

        return {
            "fluency_score": result["fluency_score"],
            "pronunciation_score": result["pronunciation_score"],
        }

    def _get_score_using_azure_speech_service(
        self,
        lang: str,
        script: str,
        audio_file_path: str,
    ) -> dict:
        """Evaluate pronunciation of audio file using Azure Speech Service.

        Args:
            lang: English locale used in audio file: en-US, en-GB, or en-AU
            script: Script read in audio file.
            audio_file_path: Absolute path of audio file.

        Returns:
            Evaluation components:
                - accuracy_score (float): Accuracy score.
                - fluency_score (float): Fluency score.
                - completeness_score (float): Completeness score.
                - pronunciation_score (float): Pronunciation score.
                Note: Excluding prosody score as its impact on fluency and pronunciation scores is unclear.
        """
        # Creates an instance of a speech config with specified subscription key and endpoint.
        # Note: The sample is for en-US language.
        speech_config = speechsdk.SpeechConfig(
            subscription=settings.az_speech_api_key,
            region=settings.az_region,
            speech_recognition_language=lang,
        )

        # Create audio config
        audio_config = speechsdk.audio.AudioConfig(filename=audio_file_path)

        # Ref. https://learn.microsoft.com/en-us/azure/ai-services/speech-service/how-to-recognize-speech?pivots=programming-language-csharp#change-how-silence-is-handled
        # speech_config.set_property(
        #     speechsdk.PropertyId.Speech_SegmentationSilenceTimeoutMs, "1500"
        # )

        # Extract words from script.
        reference_words = [
            w.strip(string.punctuation) for w in script.lower().split()
        ]
        # Remove empty words.
        reference_words = [w for w in reference_words if len(w.strip()) > 0]
        reference_text = " ".join(reference_words)
        self._logger.debug(f"Reference text: {reference_text}")

        pronunciation_config = speechsdk.PronunciationAssessmentConfig(
            reference_text=reference_text,
            grading_system=speechsdk.PronunciationAssessmentGradingSystem.HundredMark,
            # FullText cannot evaluate per word, so must set Phoneme or Word.
            granularity=speechsdk.PronunciationAssessmentGranularity.Phoneme,
            # Ref. https://learn.microsoft.com/en-us/azure/ai-services/speech-service/how-to-pronunciation-assessment?pivots=programming-language-python#streaming-vs-continuous-mode
            # > If your audio file exceeds 30 seconds, use continuous mode for processing. In continuous mode, the EnableMiscue option is not supported. To obtain Omission and Insertion tags, you need to compare the recognized results with the reference text.
            # App handles audio over 30s with continuous mode, miscue is disabled.
            enable_miscue=False,
        )
        # NOTE: Prosody is disabled.
        # Ref. https://learn.microsoft.com/en-us/azure/ai-services/speech-service/how-to-pronunciation-assessment?pivots=programming-language-python#configuration-methods
        # > Prosody assessment is only available in the en-US locale.
        # App also uses en-GB and en-AU, Prosody assessment is disabled.

        # Creates a speech recognizer using a file as audio input.
        speech_recognizer = speechsdk.SpeechRecognizer(
            speech_config=speech_config,
            language=lang,
            audio_config=audio_config,
        )
        pronunciation_config.apply_to(speech_recognizer)

        # Result components.
        recognized_words = []
        pronunciation_scores = []
        durations = []
        startOffset = 0
        endOffset = 0

        def on_end_recognition(evt: speechsdk.SessionEventArgs):
            """callback that signals to stop continuous recognition upon receiving an event `evt`"""
            self._logger.debug(f"CLOSING on {evt}")
            # Notify when it's finished.
            self._end_event.set()

        def recognized(evt: speechsdk.SpeechRecognitionEventArgs):
            if evt.result.reason != speechsdk.ResultReason.RecognizedSpeech:
                # Failed to recognize
                details = speechsdk.CancellationDetails(evt.result)
                self._logger.debug(f"recognize failed: {details.reason}")
                return

            pronunciation_result = speechsdk.PronunciationAssessmentResult(
                evt.result
            )

            for require_attr in ["pronunciation_score", "words"]:
                if not hasattr(pronunciation_result, require_attr):
                    # Missing required score
                    self._logger.debug(f"recognize failed: no {require_attr}")
                    return

            try:
                self._logger.debug(
                    f"pronunciation assessment for: {evt.result.text}, "
                    f"Accuracy score: {pronunciation_result.accuracy_score}, "
                    f"Fluency score: {pronunciation_result.fluency_score}, "
                    f"Completeness score : {pronunciation_result.completeness_score}, "
                    f"Pronunciation score: {pronunciation_result.pronunciation_score}"
                )
            except Exception as e:
                # ignore
                self._logger.error(str(e))

            nonlocal recognized_words, startOffset, endOffset
            recognized_words += pronunciation_result.words
            pronunciation_scores.append(
                pronunciation_result.pronunciation_score
            )
            json_result = evt.result.properties.get(
                speechsdk.PropertyId.SpeechServiceResponse_JsonResult
            )
            jo = json.loads(json_result)
            nb = jo["NBest"][0]
            durations.extend(
                [
                    int(w["Duration"]) + 100000
                    for w in nb["Words"]
                    if w["PronunciationAssessment"]["ErrorType"] == "None"
                ]
            )
            if startOffset == 0:
                startOffset = nb["Words"][0]["Offset"]
            endOffset = (
                nb["Words"][-1]["Offset"]
                + nb["Words"][-1]["Duration"]
                + 100000
            )

        # Connect callbacks.
        # Connect callbacks to evaluate each word and score.
        speech_recognizer.recognized.connect(recognized)
        # Stop recognition on either session stopped or canceled events.
        speech_recognizer.session_stopped.connect(on_end_recognition)
        speech_recognizer.canceled.connect(on_end_recognition)

        # Start continuous assessment
        speech_recognizer.start_continuous_recognition()

        # Wait for completion
        self._end_event.wait()

        # Terminate continuous assessment
        speech_recognizer.stop_continuous_recognition()

        # Calculate scores.

        # Compare with reference text and received all recognized words.
        reference_words = self._align_lists_with_diff_handling(
            reference_words, [x.word.lower() for x in recognized_words]
        )
        diff = difflib.SequenceMatcher(
            None,
            reference_words,
            [x.word.lower() for x in recognized_words],
        )
        final_words = []
        for tag, i1, i2, j1, j2 in diff.get_opcodes():
            if tag in ["insert", "replace"]:
                for word in recognized_words[j1:j2]:
                    word._error_type = "Insertion"
                    final_words.append(word)
            if tag in ["delete", "replace"]:
                for word_text in reference_words[i1:i2]:
                    word = speechsdk.PronunciationAssessmentWordResult(
                        {
                            "Word": word_text,
                            "PronunciationAssessment": {
                                "ErrorType": "Omission",
                            },
                        }
                    )
                    final_words.append(word)
            if tag == "equal":
                final_words += recognized_words[j1:j2]

        # If accuracy score is below 60, consider as mispronunciation
        for idx, word in enumerate(final_words):
            if word.accuracy_score < 60 and word.error_type == "None":
                word._error_type = "Mispronunciation"

        # Total duration of non-error
        durations_sum = 0
        for w, d in zip(recognized_words, durations):
            if w.error_type == "None":
                durations_sum += d

        # Accuracy score = average of recognized words' score.
        final_accuracy_scores = []
        for word in final_words:
            if word.error_type == "Insertion":
                continue
            else:
                final_accuracy_scores.append(word.accuracy_score)
        accuracy_score = sum(final_accuracy_scores) / len(
            final_accuracy_scores
        )

        # Re-calculate fluency score
        # Fluency score
        #   = total duration per word / total duration of reference_text
        fluency_score = 0
        if startOffset > 0:
            fluency_score = durations_sum / (endOffset - startOffset) * 100

        # Completeness score
        #   = non-error recognized words / recognized words
        handled_final_words = [
            w.word for w in final_words if w.error_type != "Insertion"
        ]
        completeness_score = (
            len([w for w in final_words if w.error_type == "None"])
            / len(handled_final_words)
            * 100
        )
        completeness_score = (
            completeness_score if completeness_score <= 100 else 100
        )

        # Pronunciation score = average of pronunciation score.
        pronunciation_score = 0.0
        if len(pronunciation_scores) > 0:
            pronunciation_score = sum(pronunciation_scores) / len(
                pronunciation_scores
            )

        self._logger.debug(
            f"  Paragraph accuracy: {accuracy_score:.0f}, "
            f"fluency: {fluency_score:.0f}, completeness: {completeness_score:.0f}, "
            f"pronunciation: {pronunciation_score:.0f}"
        )

        for idx, word in enumerate(final_words):
            self._logger.debug(
                f"    {idx + 1:03d}: word: {word.word}\taccuracy: {word.accuracy_score:.0f}\t"
                f"error_type: {word.error_type}"
            )

        return {
            "accuracy_score": float(accuracy_score),
            "fluency_score": float(fluency_score),
            "completeness_score": float(completeness_score),
            "pronunciation_score": float(pronunciation_score),
        }

    # This logic was copied from the following code.
    # Ref. https://github.com/Azure-Samples/cognitive-services-speech-sdk/blob/85b9f88daa79730a20b0501622e16515e73e4d74/scenarios/python/console/language-learning/utils.py#L165
    def _align_lists_with_diff_handling(self, raw, ref):
        from difflib import SequenceMatcher

        aligned_raw = []

        sm = SequenceMatcher(None, raw, ref)
        for tag, i1, i2, j1, j2 in sm.get_opcodes():
            if tag == "equal":
                aligned_raw.extend(raw[i1:i2])
            elif tag == "replace":
                # Strict comparison
                if "".join(raw[i1:i2]) == "".join(ref[j1:j2]):
                    aligned_raw.extend(ref[j1:j2])
                else:
                    aligned_part = self._align_raw_tokens_by_ref(
                        raw[i1:i2], ref[j1:j2]
                    )
                    aligned_raw.extend(aligned_part)
            elif tag == "delete":
                aligned_raw.extend(raw[i1:i2])
        return aligned_raw

    # This logic cites the following code.
    # Ref. https://github.com/Azure-Samples/cognitive-services-speech-sdk/blob/85b9f88daa79730a20b0501622e16515e73e4d74/scenarios/python/console/language-learning/utils.py#L189
    # License: MIT license: https://github.com/Azure-Samples/cognitive-services-speech-sdk
    def _align_raw_tokens_by_ref(self, raw_list, ref_list):
        ref_idx = 0
        raw_idx = 0
        ref_len = len(ref_list)
        aligned_raw = []

        # Use a copy to avoid modifying the original list.
        raw_copy = list(raw_list)

        while raw_idx < len(raw_copy) and ref_idx < ref_len:
            merged_split_done = False
            for length in range(1, len(raw_copy) + 1):
                if raw_idx + length > len(raw_copy):
                    break
                merged_raw = "".join(raw_copy[raw_idx : raw_idx + length])
                ref_word = ref_list[ref_idx]

                if ref_word in merged_raw:
                    parts = merged_raw.split(ref_word, 1)

                    # Handle prefix part before ref_word
                    if parts[0]:
                        aligned_raw.append(parts[0])

                    # Append the matched ref_word
                    aligned_raw.append(ref_word)

                    # Handle suffix part after ref_word
                    if parts[1]:
                        raw_copy[raw_idx] = parts[1]
                        # Remove the extra merged tokens
                        for _ in range(1, length):
                            raw_copy.pop(raw_idx + 1)
                    else:
                        # No suffix: remove all merged tokens
                        for _ in range(length):
                            raw_copy.pop(raw_idx)

                    ref_idx += 1
                    merged_split_done = True

                if merged_split_done:
                    break

                # If no match after merging all tokens,
                # align current token directly
                if length == len(raw_copy):
                    aligned_raw.append(raw_copy[raw_idx])
                    raw_idx += 1
                    ref_idx += 1

        # Append any remaining raw tokens
        while raw_idx < len(raw_copy):
            aligned_raw.append(raw_copy[raw_idx])
            raw_idx += 1

        return aligned_raw

    def _copy_audio_file(self, src_path: str):
        current_dir = pathlib.Path(__file__).resolve().parent
        target_dir = f"{current_dir}/tmp"
        shutil.copy2(src_path, target_dir)
        self._logger.debug(f"copied tmp={src_path} to_dir={target_dir}")

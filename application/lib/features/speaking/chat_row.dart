import 'package:flutter/material.dart';
import 'package:ielts_ai_trainer/shared/views/buttons.dart';

/// A widget displays a chat message in a chat-like style.
class ChatRow extends StatelessWidget {
  static const String _userImageAssetName = 'assets/chat_user.png';
  static const String _aiImageAssetName = 'assets/chat_ai.png';

  /// Whether this message is from the user.
  final bool isUser;

  /// The text content of the message.
  final String text;

  /// The index of this message in the conversation, starting at 1.
  final int? index;

  /// Called when the Recording button is pressed.
  final void Function(int index)? onPressedRecording;

  /// Called when the Play button is pressed.
  final void Function(int index)? onPressedPlay;

  /// The label text for the Play button.
  final String playingButtonLabel;

  /// The label text for the Recording button.
  final String recordingButtonLabel;

  /// Whether to show the Recording button.
  final bool showRecordingButton;

  /// Whether to show the Play button.
  final bool showPlayButton;

  /// The asset name for the avatar image.
  final String _assetName;

  /// Whether to display on the result screen.
  final bool isResultView;

  /// The fluency score of an audio.
  final double? fluencyScore;

  const ChatRow({
    super.key,
    required this.isUser,
    required this.text,
    this.playingButtonLabel = 'Play',
    this.recordingButtonLabel = 'Recording',
    this.showRecordingButton = false,
    this.showPlayButton = false,
    this.index,
    this.onPressedPlay,
    this.onPressedRecording,
    this.isResultView = false,
    this.fluencyScore = 0.0,
  }) : _assetName = isUser ? _userImageAssetName : _aiImageAssetName;

  /// Font size for message texts.
  double get fontSize => isResultView ? 14 : 16;

  /// Builds a Row widget containing the avator icon.
  Widget _avatarIcon() {
    const margin = SizedBox(width: 20);
    return Row(
      children: [
        if (isUser) margin,
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: CircleAvatar(
            radius: isResultView ? 16 : 20,
            backgroundImage: AssetImage(_assetName),
            backgroundColor: Colors.white,
          ),
        ),
        if (!isUser) margin,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final messageBackgroundColor = Colors.grey.shade200;

    return Row(
      mainAxisAlignment: isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        if (!isUser) _avatarIcon(),
        // Message, Recording button, and Play button.
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: messageBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question or reply text.
                Text(text, style: TextStyle(fontSize: fontSize)),
                // Shows a recording and play button only if in a user message.
                if (isUser && (showRecordingButton || showPlayButton)) ...[
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.end,
                    children: [
                      // Recording buttoon
                      if (showRecordingButton)
                        buildOutlinedButton(
                          recordingButtonLabel,
                          onPressed: onPressedRecording == null && index != null
                              ? null
                              : () => onPressedRecording!(index!),
                        ),
                      if (isResultView && fluencyScore != null) ...[
                        Text('Fluency: $fluencyScore'),
                      ],
                      // Play button
                      if (showPlayButton)
                        buildOutlinedButton(
                          playingButtonLabel,
                          onPressed: onPressedPlay == null && index != null
                              ? null
                              : () => onPressedPlay!(index!),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
        // User avator icon
        if (isUser) _avatarIcon(),
      ],
    );
  }
}

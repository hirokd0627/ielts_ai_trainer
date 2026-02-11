/// Test task types
enum TestTask {
  writingTask1,
  writingTask2,
  speakingPart1,
  speakingPart2,
  speakingPart3;

  /// Returns true if this task is a writing type.
  bool get isWriting {
    return this == TestTask.writingTask1 || this == TestTask.writingTask2;
  }

  /// Returns true if this task is a speaking type.
  bool get isSpeaking {
    return this == TestTask.speakingPart1 ||
        this == TestTask.speakingPart2 ||
        this == TestTask.speakingPart3;
  }

  /// Returns the part or task number.
  int get number {
    return switch (this) {
      TestTask.speakingPart1 => 1,
      TestTask.speakingPart2 => 2,
      TestTask.speakingPart3 => 3,
      TestTask.writingTask1 => 1,
      TestTask.writingTask2 => 2,
    };
  }
}

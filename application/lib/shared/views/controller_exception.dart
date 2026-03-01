/// An exception thrown from Controller.
class ControllerException implements Exception {
  final String message;
  final Object? exception;
  final StackTrace? stackTrace;

  ControllerException(this.message, {this.exception, this.stackTrace});

  @override
  String toString() {
    return message;
  }
}

import 'dart:io';

/// An exception represents Backend API error.
class ApiException extends HttpException {
  final int statusCode;

  ApiException(super.message, {this.statusCode = 500, super.uri});

  @override
  String toString() {
    return 'ApiException: $message (Status: $statusCode)';
  }
}

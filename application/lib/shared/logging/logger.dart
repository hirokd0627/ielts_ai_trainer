import 'package:logger/logger.dart';

/// Creates and returns a Logger with the given name.
Logger createLogger(String name) {
  return Logger(printer: NamedLogPrinter(name));
}

/// LogPrinter that prints logs with a name in the format: "[name] message".
class NamedLogPrinter extends LogPrinter {
  /// Logger name
  final String name;

  NamedLogPrinter(this.name);

  @override
  List<String> log(LogEvent event) {
    final line = "[$name] ${event.message}";
    return [line];
  }
}

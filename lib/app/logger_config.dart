import 'package:logger/logger.dart';

class LoggerConfig {
  LoggerConfig._();

  static final _instance = LoggerConfig._();

  static LoggerConfig get instance => _instance;

  final Logger _logger = Logger(printer: PrettyPrinter());

  Logger get logger => _logger;
}

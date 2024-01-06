import 'package:flutter_modular/flutter_modular.dart';
import 'package:nutrilog/app/core/services/logger/logger_service.dart';

void logInfo(String message) {
  Modular.get<LoggerService>().log(message);
}

void logError(exception, {StackTrace? stackTrace, String? message}) {
  if (message != null) Modular.get<LoggerService>().log(message);
  Modular.get<LoggerService>().recordError(exception, stackTrace ?? StackTrace.current);
}

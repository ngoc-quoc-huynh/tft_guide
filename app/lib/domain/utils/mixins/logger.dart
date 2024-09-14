import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/injector.dart';

mixin LoggerMixin {
  void logInfo(
    String name,
    String message, {
    Map<String, dynamic>? parameters,
  }) =>
      _loggerAPI.logInfo(
        name,
        message,
        parameters: parameters,
      );

  void logWarning(
    String name,
    String message, {
    Map<String, dynamic>? parameters,
  }) =>
      _loggerAPI.logWarning(
        name,
        message,
        parameters: parameters,
      );

  void logException(
    String name, {
    required Exception exception,
    required StackTrace stackTrace,
    Map<String, dynamic>? parameters,
  }) =>
      _loggerAPI.logException(
        name,
        exception: exception,
        stackTrace: stackTrace,
        parameters: parameters,
      );

  void logOtherException(
    String name, {
    required Exception exception,
    required StackTrace stackTrace,
    Map<String, dynamic>? parameters,
  }) {
    if (exception is! CustomException) {
      logException(
        name,
        exception: exception,
        stackTrace: stackTrace,
        parameters: parameters,
      );
    }
  }

  static final _loggerAPI = Injector.instance.loggerApi;
}

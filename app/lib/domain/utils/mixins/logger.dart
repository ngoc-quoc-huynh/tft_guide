import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/injector.dart';

mixin LoggerMixin {
  void logInfo(
    String name,
    String message, {
    required StackTrace stackTrace,
    Map<String, String?>? parameters,
  }) =>
      _loggerAPI.logInfo(
        name,
        message,
        parameters: parameters,
        stackTrace: stackTrace,
      );

  void logWarning(
    String name,
    String message, {
    required StackTrace stackTrace,
    Map<String, String?>? parameters,
  }) =>
      _loggerAPI.logWarning(
        name,
        message,
        parameters: parameters,
        stackTrace: stackTrace,
      );

  void logException(
    String name, {
    required Exception exception,
    required StackTrace stackTrace,
    Map<String, String?>? parameters,
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
    Map<String, String?>? parameters,
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

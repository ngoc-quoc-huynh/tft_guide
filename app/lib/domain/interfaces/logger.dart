abstract interface class LoggerApi {
  const LoggerApi();

  void logInfo(
    String name,
    String message, {
    Map<String, dynamic>? parameters,
  });

  void logWarning(
    String name,
    String message, {
    Map<String, dynamic>? parameters,
  });

  void logException(
    String name, {
    required Exception exception,
    required StackTrace stackTrace,
    Map<String, dynamic>? parameters,
  });
}

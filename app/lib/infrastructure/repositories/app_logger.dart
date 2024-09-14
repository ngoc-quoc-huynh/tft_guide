import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';

final class AppLogger implements LoggerApi {
  AppLogger();

  static final _logger = Logger();
  static const _encoder = JsonEncoder.withIndent('  ');

  @override
  void logException(
    String name, {
    required Exception exception,
    required StackTrace stackTrace,
    Map<String, dynamic>? parameters,
  }) =>
      _logger.e(
        _buildMessage(
          name,
          parameters: parameters,
        ),
        error: exception,
        stackTrace: stackTrace,
      );

  @override
  void logInfo(
    String name,
    String message, {
    Map<String, dynamic>? parameters,
  }) =>
      _logger.i(
        _buildMessage(
          name,
          message: message,
          parameters: parameters,
        ),
      );

  @override
  void logWarning(
    String name,
    String message, {
    Map<String, dynamic>? parameters,
  }) =>
      _logger.w(
        _buildMessage(
          name,
          message: message,
          parameters: parameters,
        ),
      );

  String _buildMessage(
    String name, {
    String? message,
    Map<String, dynamic>? parameters,
  }) =>
      '''
$name
${_encoder.convert(
        {
          if (parameters != null) 'parameters': parameters,
          if (message != null) 'message': message,
        },
      )}''';
}

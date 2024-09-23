import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';

@immutable
final class AppLogger implements LoggerApi {
  const AppLogger();

  static final _logger = Logger();
  static const _encoder = JsonEncoder.withIndent('  ');

  @override
  void logException(
    String methodName, {
    required Exception exception,
    required StackTrace stackTrace,
    Map<String, dynamic>? parameters,
  }) =>
      _logger.e(
        _buildMessage(
          methodName,
          parameters: parameters,
        ),
        error: exception,
        stackTrace: stackTrace,
      );

  @override
  void logInfo(
    String methodName,
    String message, {
    required StackTrace stackTrace,
    Map<String, dynamic>? parameters,
  }) =>
      _logger.i(
        _buildMessage(
          methodName,
          message: message,
          parameters: parameters,
        ),
        stackTrace: stackTrace,
      );

  @override
  void logWarning(
    String methodName,
    String message, {
    required StackTrace stackTrace,
    Map<String, dynamic>? parameters,
  }) =>
      _logger.w(
        _buildMessage(
          methodName,
          message: message,
          parameters: parameters,
        ),
        stackTrace: stackTrace,
      );

  String _buildMessage(
    String methodName, {
    String? message,
    Map<String, dynamic>? parameters,
  }) =>
      '''
$methodName
${_encoder.convert(
        {
          if (parameters != null) 'parameters': parameters,
          if (message != null) 'message': message,
        },
      )}''';
}

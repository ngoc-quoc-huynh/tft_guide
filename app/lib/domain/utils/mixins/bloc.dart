import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tft_guide/domain/exceptions/base.dart';
import 'package:tft_guide/injector.dart';

mixin BlocMixin {
  static final _loggerApi = Injector.instance.loggerApi;

  Future<bool> executeSafely({
    required String methodName,
    required FutureOr<void> Function() function,
    required VoidCallback onError,
  }) async {
    try {
      await function();
      return true;
    } on CustomException {
      onError();
      return false;
    } on Exception catch (e, stackTrace) {
      _loggerApi.logException(
        methodName,
        exception: e,
        stackTrace: stackTrace,
      );
      onError();
      return false;
    }
  }
}

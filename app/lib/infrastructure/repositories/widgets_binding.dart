import 'package:flutter/widgets.dart';
import 'package:tft_guide/domain/interfaces/widgets_binding.dart';
import 'package:tft_guide/domain/utils/mixins/logger.dart';

@immutable
final class WidgetsBindingRepository
    with LoggerMixin
    implements WidgetsBindingApi {
  const WidgetsBindingRepository();

  @override
  Brightness get brightness {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    logInfo(
      'WidgetsBindingRepository.brightness',
      'Retrieved brightness: $brightness.',
      stackTrace: StackTrace.current,
    );

    return brightness;
  }

  @override
  Locale get locale {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    logInfo(
      'WidgetsBindingRepository.locale',
      'Retrieved locale: $locale',
      stackTrace: StackTrace.current,
    );

    return locale;
  }
}

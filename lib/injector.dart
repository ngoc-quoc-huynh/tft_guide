import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:tft_guide/static/i18n/messages.i18n.dart';

export 'package:tft_guide/domain/utils/extensions/get_it.dart';

final class Injector {
  const Injector._();

  static final GetIt instance = GetIt.instance;

  static void setupDependencies() =>
      instance.registerLazySingleton<Messages>(_createMessages);

  static Messages _createMessages() {
    switch (PlatformDispatcher.instance.locale.languageCode) {
      default:
        return const Messages();
    }
  }
}

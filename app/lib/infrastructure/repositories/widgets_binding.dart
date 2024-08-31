import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tft_guide/domain/interfaces/widgets_binding.dart';

final class WidgetsBindingRepository implements WidgetsBindingApi {
  const WidgetsBindingRepository();

  @override
  Brightness get brightness =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness;

  @override
  Locale get locale => WidgetsBinding.instance.platformDispatcher.locale;
}

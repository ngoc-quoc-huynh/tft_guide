import 'package:flutter/widgets.dart';

abstract interface class WidgetsBindingApi {
  const WidgetsBindingApi();

  Brightness get brightness;

  Locale get locale;
}

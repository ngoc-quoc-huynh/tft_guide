import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/injector.dart';

class WidgetObserver extends StatefulWidget {
  const WidgetObserver({
    required this.child,
    this.onBrightnessChanged,
    this.onLanguageChanged,
    super.key,
  });

  final Widget child;
  final ValueChanged<Brightness>? onBrightnessChanged;
  final ValueChanged<LanguageCode>? onLanguageChanged;

  @override
  State<WidgetObserver> createState() => WidgetObserverState();
}

@visibleForTesting
class WidgetObserverState extends State<WidgetObserver>
    with WidgetsBindingObserver {
  static final _widgetsBindingApi = Injector.instance.widgetsBindingApi;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    if (context.read<HydratedThemeModeCubit>().state == ThemeMode.system) {
      widget.onBrightnessChanged?.call(
        _widgetsBindingApi.brightness,
      );
    }
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);
    if (context.read<HydratedTranslationLocaleCubit>().state ==
        TranslationLocale.system) {
      widget.onLanguageChanged?.call(
        LanguageCode.byLanguageCode(
          _widgetsBindingApi.locale.languageCode,
        ),
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

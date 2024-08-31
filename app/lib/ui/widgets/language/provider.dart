import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/language_code/cubit.dart';
import 'package:tft_guide/domain/blocs/translation_locale/cubit.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/language/builder.dart';
import 'package:tft_guide/ui/widgets/widget_observer.dart';

class LanguageProvider extends StatelessWidget {
  const LanguageProvider({
    required this.locale,
    required this.child,
    super.key,
  });

  final TranslationLocale locale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCodeCubit>(
      create: (_) => LanguageCodeCubit(
        _computeLanguageCode(locale),
      ),
      child: LanguageBuilder(
        builder: (context) => WidgetObserver(
          onLanguageChanged: (languageCode) =>
              context.read<LanguageCodeCubit>().update(languageCode),
          child: BlocListener<TranslationLocaleCubit, TranslationLocale>(
            listener: _onTranslationLocaleChanged,
            child: child,
          ),
        ),
      ),
    );
  }

  LanguageCode _computeLanguageCode(TranslationLocale locale) =>
      switch (locale) {
        TranslationLocale.german => LanguageCode.de,
        TranslationLocale.english => LanguageCode.en,
        TranslationLocale.system => LanguageCode.byLanguageCode(
            Injector.instance.widgetsBindingApi.locale.languageCode,
          ),
      };

  void _onTranslationLocaleChanged(
    BuildContext context,
    TranslationLocale locale,
  ) =>
      context.read<LanguageCodeCubit>().update(
            _computeLanguageCode(locale),
          );
}

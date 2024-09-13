import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/translation_locale/cubit.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/ui/widgets/radio_dialog/dialog.dart';
import 'package:tft_guide/ui/widgets/radio_dialog/option.dart';

class SettingsLanguageDialog extends StatelessWidget {
  const SettingsLanguageDialog._();

  static Future<void> show(BuildContext context) async {
    final translationLocale = await showDialog<TranslationLocale?>(
      context: context,
      useRootNavigator: false,
      builder: (context) => const SettingsLanguageDialog._(),
    );
    if (context.mounted && translationLocale != null) {
      context.read<TranslationLocaleCubit>().change(translationLocale);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TranslationLocaleValueCubit>(
      create: (_) => TranslationLocaleValueCubit(
        context.read<TranslationLocaleCubit>().state,
      ),
      child: RadioDialog<TranslationLocale>(
        title: _translations.title,
        options: [
          RadioDialogOption(
            title: _translations.german,
            value: TranslationLocale.german,
          ),
          RadioDialogOption(
            title: _translations.english,
            value: TranslationLocale.english,
          ),
          RadioDialogOption(
            title: _translations.system,
            value: TranslationLocale.system,
          ),
        ],
      ),
    );
  }

  static TranslationsPagesSettingsLanguageEn get _translations =>
      Injector.instance.translations.pages.settings.language;
}

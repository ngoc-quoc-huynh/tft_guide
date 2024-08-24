import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/translation_locale/cubit.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const routeName = 'settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocBuilder<TranslationLocaleCubit, TranslationLocale?>(
        builder: (context, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () => context
                  .read<TranslationLocaleCubit>()
                  .change(TranslationLocale.german),
              child: Text(_translations.german),
            ),
            TextButton(
              onPressed: () => context
                  .read<TranslationLocaleCubit>()
                  .change(TranslationLocale.english),
              child: Text(_translations.english),
            ),
            TextButton(
              onPressed: () => context
                  .read<TranslationLocaleCubit>()
                  .change(TranslationLocale.system),
              child: Text(_translations.system),
            ),
          ],
        ),
      ),
    );
  }

  TranslationsPagesSettingsDe get _translations =>
      Injector.instance.translations.pages.settings;
}

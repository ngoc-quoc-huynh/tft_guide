import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/language/cubit.dart';
import 'package:tft_guide/domain/models/language.dart';
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
      body: BlocBuilder<LanguageCubit, Language?>(
        builder: (context, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () =>
                  context.read<LanguageCubit>().change(Language.german),
              child: Text(_messages.german),
            ),
            TextButton(
              onPressed: () =>
                  context.read<LanguageCubit>().change(Language.english),
              child: Text(_messages.english),
            ),
            TextButton(
              onPressed: () =>
                  context.read<LanguageCubit>().change(Language.system),
              child: Text(_messages.system),
            ),
          ],
        ),
      ),
    );
  }

  TranslationsPagesSettingsDe get _messages =>
      Injector.instance.translations.pages.settings;
}

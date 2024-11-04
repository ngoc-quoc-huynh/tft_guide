import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/radio_dialog/dialog.dart';
import 'package:tft_guide/ui/widgets/radio_dialog/option.dart';

class SettingsDesignDialog extends StatelessWidget {
  const SettingsDesignDialog({super.key});

  static Future<void> show(BuildContext context) async {
    final themeMode = await showDialog<ThemeMode?>(
      context: context,
      useRootNavigator: false,
      builder: (context) => const SettingsDesignDialog(),
    );
    if (context.mounted && themeMode != null) {
      context.read<HydratedThemeModeCubit>().update(themeMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeModeValueCubit>(
      create: (_) => ThemeModeValueCubit(
        context.read<HydratedThemeModeCubit>().state,
      ),
      child: RadioDialog<ThemeMode>(
        title: _translations.title,
        options: [
          RadioDialogOption(
            title: _translations.light,
            value: ThemeMode.light,
          ),
          RadioDialogOption(
            title: _translations.dark,
            value: ThemeMode.dark,
          ),
          RadioDialogOption(
            title: _translations.system,
            value: ThemeMode.system,
          ),
        ],
      ),
    );
  }

  static TranslationsPagesSettingsDesignEn get _translations =>
      Injector.instance.translations.pages.settings.design;
}

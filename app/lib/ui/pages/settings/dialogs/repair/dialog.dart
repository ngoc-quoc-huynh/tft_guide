import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/repair/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/repair/button.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/repair/title.dart';
import 'package:tft_guide/ui/widgets/dialog.dart';
import 'package:tft_guide/ui/widgets/progress_bar.dart';

class SettingsRepairDialog extends StatelessWidget {
  const SettingsRepairDialog._();

  static Future<void> show(BuildContext context) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        builder: (context) => const SettingsRepairDialog._(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RepairBloc>(
      create: (_) => RepairBloc(),
      child: CustomDialog(
        title: const SettingsRepairTitle(),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_repairTranslations.description),
            const SizedBox(height: 10),
            BlocSelector<RepairBloc, RepairState, double>(
              selector: (state) => state.progress,
              builder: (context, progress) => ProgressBar(value: progress),
            ),
          ],
        ),
        action: const SettingsRepairStartButton(),
      ),
    );
  }

  static Translations get _translations => Injector.instance.translations;

  static TranslationsPagesSettingsRepairEn get _repairTranslations =>
      _translations.pages.settings.repair;
}

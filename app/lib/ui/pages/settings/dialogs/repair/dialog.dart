import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/repair/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/repair/button.dart';
import 'package:tft_guide/ui/pages/settings/title_with_warning.dart';
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
        title: BlocSelector<RepairBloc, RepairState, bool>(
          selector: (state) => state is RepairLoadOnFailure,
          builder: (context, hasError) => SettingsTitleWithWarning(
            title: _translations.name,
            hasError: hasError,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_translations.description),
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

  static TranslationsPagesSettingsRepairEn get _translations =>
      Injector.instance.translations.pages.settings.repair;
}

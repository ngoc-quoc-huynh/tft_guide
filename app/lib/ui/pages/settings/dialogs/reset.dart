import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/elo/cubit.dart';
import 'package:tft_guide/domain/blocs/elo_gain/cubit.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/action.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/dialog.dart';
import 'package:tft_guide/ui/widgets/snack_bar.dart';

class SettingsResetDialog extends StatelessWidget {
  const SettingsResetDialog._();

  static Future<void> show(BuildContext context) async {
    final shouldReset = await showDialog<bool>(
      context: context,
      useRootNavigator: false,
      builder: (context) => const SettingsResetDialog._(),
    );
    if (context.mounted && (shouldReset ?? false)) {
      context
        ..read<EloCubit>().reset()
        ..read<EloGainCubit>().gain(null);

      CustomSnackBar.showSuccess(context, _translations.feedback);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: _translations.title,
      content: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Sizes.horizontalPadding),
        child: Text(_translations.content),
      ),
      actions: [
        const AlertDialogAction<void>.cancel(),
        AlertDialogAction.custom(
          text: _translations.name,
          result: () => true,
        ),
      ],
    );
  }

  static TranslationsPagesSettingsResetEn get _translations =>
      Injector.instance.translations.pages.settings.reset;
}

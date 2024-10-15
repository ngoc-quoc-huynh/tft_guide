import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/injector.dart';
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
        ..read<HydratedEloCubit>().reset()
        ..read<EloGainCubit>().update(null);

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
        const AlertDialogAction.cancel(),
        AlertDialogAction.custom(
          text: _translations.name,
          onPressed: () => context.pop(true),
        ),
      ],
    );
  }

  static TranslationsPagesSettingsResetEn get _translations =>
      Injector.instance.translations.pages.settings.reset;
}

import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/action.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/dialog.dart';

class QuitDialog extends StatelessWidget {
  const QuitDialog._();

  static Future<bool> show(BuildContext context) async {
    final isQuitting = await showDialog<bool>(
      context: context,
      useRootNavigator: false,
      builder: (_) => const QuitDialog._(),
    );
    return isQuitting ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: _quitTranslations.title,
      content: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Sizes.horizontalPadding),
        child: Text(_quitTranslations.content),
      ),
      actions: [
        const AlertDialogAction<void>.cancel(),
        AlertDialogAction.custom(
          result: () => true,
          text: _quitTranslations.button,
        ),
      ],
    );
  }

  Translations get _translations => Injector.instance.translations;

  TranslationsPagesGameQuitEn get _quitTranslations =>
      _translations.pages.game.quit;
}

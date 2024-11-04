import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/action.dart';
import 'package:tft_guide/ui/widgets/alert_dialog/dialog.dart';

class QuitDialog extends StatelessWidget {
  const QuitDialog({super.key});

  static Future<bool> show(BuildContext context) async {
    final isQuitting = await showDialog<bool>(
      context: context,
      useRootNavigator: false,
      builder: (_) => const QuitDialog(),
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
        const AlertDialogAction.cancel(),
        AlertDialogAction.custom(
          onPressed: () => context.pop(true),
          text: _quitTranslations.button,
        ),
      ],
    );
  }

  static TranslationsPagesGameQuitEn get _quitTranslations =>
      Injector.instance.translations.pages.game.quit;
}

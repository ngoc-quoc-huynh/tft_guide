import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

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
    return AlertDialog(
      title: Text(_quitTranslations.title),
      content: Text(_quitTranslations.content),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(_translations.general.cancel),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(_quitTranslations.button),
        ),
      ],
    );
  }

  Translations get _translations => Injector.instance.translations;

  TranslationsPagesGameQuitDe get _quitTranslations =>
      _translations.pages.game.quit;
}

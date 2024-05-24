import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// ignore_for_file: avoid-non-ascii-symbols, TODO add strings to i18n

class QuitDialog extends StatelessWidget {
  const QuitDialog._();

  static Future<bool?> show(BuildContext context) => showDialog<bool>(
        context: context,
        builder: (builder) => const QuitDialog._(),
      );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Bist du sicher?'),
      content: const Text(
        'Wenn du jetzt aufhörst, wirst du deinen aktuellen Fortschritt '
        'verlieren',
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('ABBRECHEN'),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: const Text('AUFHÖREN'),
        ),
      ],
    );
  }
}

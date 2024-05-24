import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuitDialog extends StatelessWidget {
  const QuitDialog._();

  static Future<bool> show(BuildContext context) async {
    final isQuitting = await showDialog<bool>(
      context: context,
      builder: (_) => const QuitDialog._(),
    );
    return isQuitting ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure you want to quit?'),
      content:
          const Text('If you quit now, you will lose your current progress.'),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: const Text('Quit'),
        ),
      ],
    );
  }
}

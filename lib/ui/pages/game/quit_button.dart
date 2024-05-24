import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuitButton extends StatelessWidget {
  const QuitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: () => context.pop(),
    );
  }
}

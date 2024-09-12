import 'package:flutter/material.dart';

class SettingsCheckItem extends StatelessWidget {
  const SettingsCheckItem({
    required this.icon,
    required this.text,
    super.key,
  });

  final Widget icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 10),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      iconColor: IconTheme.of(context).color,
      onTap: onTap,
    );
  }
}

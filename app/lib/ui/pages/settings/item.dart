import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    super.key,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      leading: Icon(icon),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null) trailing!,
          const Icon(Icons.chevron_right),
        ],
      ),
      iconColor: IconTheme.of(context).color,
      onTap: onTap,
    );
  }
}

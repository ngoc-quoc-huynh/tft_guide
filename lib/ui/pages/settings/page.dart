import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const routeName = 'settings';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(Injector.instance.messages.pages.settings.title),
    );
  }
}

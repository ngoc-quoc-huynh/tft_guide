import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';

class SettingsAppVersion extends StatelessWidget {
  const SettingsAppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(Injector.instance.packageInfo.version),
    );
  }
}

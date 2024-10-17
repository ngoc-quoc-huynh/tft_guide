import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/config.dart';
import 'package:tft_guide/ui/widgets/dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsFeedbackDialog extends StatelessWidget {
  const SettingsFeedbackDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        builder: (_) => const SettingsFeedbackDialog(),
      );

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: Text(_translations.name),
      content: Text(_translations.description),
      action: FilledButton(
        onPressed: () => unawaited(
          launchUrl(
            Uri.https(
              'github.com',
              '/${Config.githubOwner}/${Config.githubRepo}/discussions',
            ),
            mode: LaunchMode.externalApplication,
          ),
        ),
        child: Text(_translations.submit),
      ),
    );
  }

  TranslationsPagesSettingsFeedbackEn get _translations =>
      Injector.instance.translations.pages.settings.feedback;
}

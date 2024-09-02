import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/settings/app_version.dart';
import 'package:tft_guide/ui/pages/settings/card.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/design.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/language.dart';
import 'package:tft_guide/ui/pages/settings/divider.dart';
import 'package:tft_guide/ui/pages/settings/item.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';
import 'package:tft_guide/ui/widgets/spatula_background.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const routeName = 'settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SpatulaBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.horizontalPadding,
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: Column(
                    children: [
                      SettingsCard(
                        child: Column(
                          children: [
                            SettingsItem(
                              icon: Icons.brightness_6_rounded,
                              title: _translations.design.name,
                              onTap: () => unawaited(
                                SettingsDesignDialog.show(context),
                              ),
                            ),
                            const SettingsDivider(),
                            SettingsItem(
                              icon: Icons.flag_outlined,
                              title: _translations.language.name,
                              onTap: () => unawaited(
                                SettingsLanguageDialog.show(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SettingsCard(
                        child: Column(
                          children: [
                            SettingsItem(
                              icon: Icons.build,
                              title: _translations.repair.name,
                              onTap: () {
                                // TODO: Add functionality
                              },
                            ),
                            const SettingsDivider(),
                            SettingsItem(
                              icon: Icons.restart_alt,
                              title: _translations.reset.name,
                              onTap: () {
                                // TODO: Add functionality
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SettingsCard(
                        child: SettingsItem(
                          icon: Icons.library_books,
                          title: _translations.license.name,
                          onTap: () {
                            // TODO: Add functionality
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const SettingsAppVersion(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TranslationsPagesSettingsEn get _translations =>
      Injector.instance.translations.pages.settings;
}

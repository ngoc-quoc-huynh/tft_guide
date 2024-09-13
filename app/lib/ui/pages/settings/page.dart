import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/theme_mode/cubit.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/settings/app_version.dart';
import 'package:tft_guide/ui/pages/settings/card.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/dialog.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/design.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/language.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/repair/dialog.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/reset.dart';
import 'package:tft_guide/ui/pages/settings/divider.dart';
import 'package:tft_guide/ui/pages/settings/item.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';
import 'package:tft_guide/ui/widgets/language/listener.dart';
import 'package:tft_guide/ui/widgets/snack_bar.dart';
import 'package:tft_guide/ui/widgets/spatula_background.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                            BlocListener<ThemeModeCubit, ThemeMode>(
                              listener: (context, _) =>
                                  CustomSnackBar.showSuccess(
                                context,
                                Injector.instance.translations.pages.settings
                                    .design.feedback,
                              ),
                              child: SettingsItem(
                                icon: Icons.brightness_6_rounded,
                                title: _translations.design.name,
                                onTap: () => unawaited(
                                  SettingsDesignDialog.show(context),
                                ),
                              ),
                            ),
                            const SettingsDivider(),
                            LanguageListener(
                              onLanguageChanged: (_) =>
                                  CustomSnackBar.showSuccess(
                                context,
                                Injector.instance.translations.pages.settings
                                    .language.feedback,
                              ),
                              child: SettingsItem(
                                icon: Icons.flag_outlined,
                                title: _translations.language.name,
                                onTap: () => unawaited(
                                  SettingsLanguageDialog.show(context),
                                ),
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
                              icon: Icons.checklist,
                              title: _translations.check.name,
                              onTap: () =>
                                  unawaited(SettingsCheckDialog.show(context)),
                            ),
                            const SettingsDivider(),
                            SettingsItem(
                              icon: Icons.build,
                              title: _translations.repair.name,
                              onTap: () =>
                                  unawaited(SettingsRepairDialog.show(context)),
                            ),
                            const SettingsDivider(),
                            SettingsItem(
                              icon: Icons.restart_alt,
                              title: _translations.reset.name,
                              onTap: () {
                                unawaited(SettingsResetDialog.show(context));
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

  static TranslationsPagesSettingsEn get _translations =>
      Injector.instance.translations.pages.settings;
}

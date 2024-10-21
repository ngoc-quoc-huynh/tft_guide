import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/app_update_info/cubit.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/app_update_info.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/settings/app_version.dart';
import 'package:tft_guide/ui/pages/settings/card.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/app_update.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/check/dialog.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/design.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/feedback.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/language.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/repair/dialog.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/reset.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/update_elo.dart';
import 'package:tft_guide/ui/pages/settings/divider.dart';
import 'package:tft_guide/ui/pages/settings/item.dart';
import 'package:tft_guide/ui/router/routes.dart';
import 'package:tft_guide/ui/widgets/badge.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';
import 'package:tft_guide/ui/widgets/language/listener.dart';
import 'package:tft_guide/ui/widgets/scaffold.dart';
import 'package:tft_guide/ui/widgets/snack_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar.tft(),
      bottomNavigationBar: const SettingsAppVersion(),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.horizontalPadding,
        ),
        children: [
          const SizedBox(height: Sizes.verticalPadding),
          Column(
            children: [
              SettingsCard(
                child: Column(
                  children: [
                    SettingsItem(
                      icon: Icons.update,
                      title: _translations.appUpdate.name,
                      trailing: BlocBuilder<AppUpdateInfoCubit, AppUpdateInfo?>(
                        builder: (context, state) {
                          return switch (state) {
                            AppUpdateInfo() => const BadgeCounter(count: 1),
                            null => const SizedBox.shrink(),
                          };
                        },
                      ),
                      onTap: () => unawaited(
                        SettingsAppUpdateDialog.show(
                          context,
                          context.read<AppUpdateInfoCubit>().state,
                        ),
                      ),
                    ),
                    const SettingsDivider(),
                    BlocListener<HydratedThemeModeCubit, ThemeMode>(
                      listener: (context, _) => CustomSnackBar.showSuccess(
                        context,
                        _translations.design.feedback,
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
                      onLanguageChanged: (_) => CustomSnackBar.showSuccess(
                        context,
                        _translations.language.feedback,
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
                      onTap: () => unawaited(SettingsCheckDialog.show(context)),
                    ),
                    const SettingsDivider(),
                    SettingsItem(
                      icon: Icons.build,
                      title: _translations.repair.name,
                      onTap: () =>
                          unawaited(SettingsRepairDialog.show(context)),
                    ),
                    BlocBuilder<AdminCubit, bool>(
                      builder: (context, isAdmin) => switch (isAdmin) {
                        false => const SizedBox(),
                        true => Column(
                            children: [
                              const SettingsDivider(),
                              BlocListener<HydratedEloCubit, int>(
                                listener: (context, elo) =>
                                    CustomSnackBar.showSuccess(
                                  context,
                                  _translations.updateElo.feedback,
                                ),
                                child: SettingsCard(
                                  child: SettingsItem(
                                    icon: Icons.edit,
                                    title: _translations.updateElo.name,
                                    onTap: () => unawaited(
                                      SettingsUpdateEloDialog.show(
                                        context,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      },
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
                  icon: Icons.feedback,
                  title: _translations.feedback.name,
                  onTap: () => unawaited(SettingsFeedbackDialog.show(context)),
                ),
              ),
              const SizedBox(height: 10),
              SettingsCard(
                child: SettingsItem(
                  icon: Icons.library_books,
                  title: _translations.license.name,
                  onTap: () => unawaited(
                    context.pushNamed(
                      Routes.licensePage(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  static TranslationsPagesSettingsEn get _translations =>
      Injector.instance.translations.pages.settings;
}

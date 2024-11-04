import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/app_update/bloc.dart';
import 'package:tft_guide/domain/models/app_update_info.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/settings/title_with_warning.dart';
import 'package:tft_guide/ui/widgets/dialog.dart';
import 'package:tft_guide/ui/widgets/markdown_text.dart';
import 'package:tft_guide/ui/widgets/progress_bar.dart';

sealed class SettingsAppUpdateDialog extends StatelessWidget {
  const SettingsAppUpdateDialog({super.key});

  const factory SettingsAppUpdateDialog.noUpdate({
    Key? key,
  }) = _NoUpdate;

  const factory SettingsAppUpdateDialog.update({
    required AppUpdateInfo appUpdateInfo,
    Key? key,
  }) = _Update;

  static Future<void> show(
    BuildContext context,
    AppUpdateInfo? appUpdateInfo,
  ) =>
      showDialog<void>(
        context: context,
        useRootNavigator: false,
        builder: (_) => switch (appUpdateInfo) {
          null => const SettingsAppUpdateDialog.noUpdate(),
          AppUpdateInfo() => SettingsAppUpdateDialog.update(
              appUpdateInfo: appUpdateInfo,
            ),
        },
      );

  @protected
  static TranslationsPagesSettingsAppUpdateEn get translations =>
      Injector.instance.translations.pages.settings.appUpdate;
}

class _NoUpdate extends SettingsAppUpdateDialog {
  const _NoUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: Text(SettingsAppUpdateDialog.translations.name),
      content: Text(SettingsAppUpdateDialog.translations.descriptionNoUpdate),
    );
  }
}

class _Update extends SettingsAppUpdateDialog {
  const _Update({
    required this.appUpdateInfo,
    super.key,
  });

  final AppUpdateInfo appUpdateInfo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppUpdateBloc(appUpdateInfo.version),
      child: CustomDialog(
        title: BlocSelector<AppUpdateBloc, AppUpdateState, bool>(
          selector: (state) => state is AppUpdateLoadOnFailure,
          builder: (context, hasError) => SettingsTitleWithWarning(
            title: SettingsAppUpdateDialog.translations.name,
            hasError: hasError,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              SettingsAppUpdateDialog.translations.descriptionUpdate(
                version: appUpdateInfo.version,
              ),
            ),
            const SizedBox(height: 10),
            MarkdownText(text: appUpdateInfo.releaseNotes),
            const SizedBox(height: 10),
            BlocSelector<AppUpdateBloc, AppUpdateState, double>(
              selector: (state) => switch (state) {
                AppUpdateInitial() || AppUpdateLoadOnFailure() => 0,
                AppUpdateLoadInProgress(:final progress) => progress,
                AppUpdateLoadOnSuccess() => 100,
              },
              builder: (context, progress) => ProgressBar(value: progress),
            ),
            const SizedBox(height: 10),
            Center(
              child: BlocConsumer<AppUpdateBloc, AppUpdateState>(
                listener: _onAppUpdateStateChanged,
                builder: (context, state) => FilledButton(
                  onPressed: switch (state) {
                    AppUpdateInitial() || AppUpdateLoadOnFailure() => () =>
                        context
                            .read<AppUpdateBloc>()
                            .add(const AppUpdateInitializeEvent()),
                    AppUpdateLoadInProgress() => null,
                    AppUpdateLoadOnSuccess() => () => context.pop(),
                  },
                  child: switch (state) {
                    AppUpdateInitial() ||
                    AppUpdateLoadInProgress() =>
                      Text(SettingsAppUpdateDialog.translations.update),
                    AppUpdateLoadOnFailure() =>
                      Text(SettingsAppUpdateDialog.translations.retry),
                    AppUpdateLoadOnSuccess() => const Icon(Icons.check),
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAppUpdateStateChanged(_, AppUpdateState state) {
    if (state is AppUpdateLoadOnSuccess) {
      unawaited(Injector.instance.nativeApi.openFile(state.path));
    }
  }
}

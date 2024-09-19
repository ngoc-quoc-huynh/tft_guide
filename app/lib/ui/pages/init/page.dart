import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/data_sync/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/init/restart_button.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';
import 'package:tft_guide/ui/widgets/error_text.dart';
import 'package:tft_guide/ui/widgets/icon.dart';
import 'package:tft_guide/ui/widgets/progress_bar.dart';
import 'package:tft_guide/ui/widgets/spatula_background.dart';

class InitPage extends StatelessWidget {
  const InitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SpatulaBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.verticalPadding,
            horizontal: Sizes.horizontalPadding,
          ),
          child: BlocBuilder<DataSyncBloc, DataSyncState>(
            builder: (context, state) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isDatabaseError(state)) const _WarningIcon(),
                ErrorText(
                  text: _message(state),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                switch (_isDatabaseError(state)) {
                  true => const InitRestartButton(),
                  false => ProgressBar(
                      value: state.progress,
                    ),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isDatabaseError(DataSyncState state) =>
      state is DataSyncInitOnFailure || state is DataSyncLocalDatabaseOnFailure;

  String _message(DataSyncState state) => switch (state) {
        DataSyncLoadOnSuccess() ||
        DataSyncAnimationInProgress() ||
        DataSyncLoadAndSaveOnFailure() =>
          _translations.finish,
        DataSyncCheckInProgress() => _translations.checkUpdates,
        DataSyncInitInProgress() => _translations.init,
        DataSyncLoadLatestUpdatedAtInProgress() =>
          _translations.checkLatestUpdate,
        DataSyncLoadRemoteDataInProgress() => _translations.load,
        DataSyncSaveDataLocallyInProgress() => _translations.save,
        DataSyncInitOnFailure() ||
        DataSyncLocalDatabaseOnFailure() =>
          _translations.errors.database,
      };

  static TranslationsPagesInitEn get _translations =>
      Injector.instance.translations.pages.init;
}

class _WarningIcon extends StatelessWidget {
  const _WarningIcon();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: CustomIcon.warning(),
    );
  }
}

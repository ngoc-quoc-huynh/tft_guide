import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/data_sync/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';
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
                Text(
                  switch (state) {
                    DataSyncLoadOnSuccess() => _translations.finish,
                    DataSyncCheckInProgress() => _translations.checkUpdates,
                    DataSyncInitInProgress() => _translations.init,
                    DataSyncLoadLatestUpdatedAtInProgress() =>
                      _translations.checkLatestUpdate,
                    DataSyncLoadRemoteDataInProgress() =>
                      _translations.loadRemoteData,
                    DataSyncStoreDataLocallyInProgress() =>
                      _translations.storeDataLocally,
                  },
                ),
                const SizedBox(height: 20),
                ProgressBar(
                  value: state.progress,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TranslationsPagesInitEn get _translations =>
      Injector.instance.translations.pages.init;
}

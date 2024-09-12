import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/check_assets/bloc.dart';
import 'package:tft_guide/domain/blocs/check_database/bloc.dart';
import 'package:tft_guide/injector.dart';

class SettingsCheckStartButton extends StatelessWidget {
  const SettingsCheckStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CheckAssetsBloc, CheckAssetsState, bool>(
      selector: (state) => state is CheckAssetsLoadInProgress,
      builder: (context, isAssetsLoading) =>
          BlocSelector<CheckBaseItemsBloc, CheckDatabaseState, bool>(
        selector: (state) => state is CheckDatabaseLoadInProgress,
        builder: (context, isBaseItemsLoading) =>
            BlocSelector<CheckFullItemsBloc, CheckDatabaseState, bool>(
          selector: (state) => state is CheckDatabaseLoadInProgress,
          builder: (context, isFullItemsLoading) =>
              BlocSelector<CheckPatchNotesBloc, CheckDatabaseState, bool>(
            selector: (state) => state is CheckDatabaseLoadInProgress,
            builder: (context, isPatchNotesLoading) => FilledButton(
              onPressed: _onPressed(
                context: context,
                isAssetsLoading: isAssetsLoading,
                isBaseItemsLoading: isBaseItemsLoading,
                isFullItemsLoading: isFullItemsLoading,
                isPatchNotesLoading: isPatchNotesLoading,
              ),
              child: Text(
                Injector.instance.translations.pages.settings.check.button,
              ),
            ),
          ),
        ),
      ),
    );
  }

  VoidCallback? _onPressed({
    required BuildContext context,
    required bool isAssetsLoading,
    required bool isBaseItemsLoading,
    required bool isFullItemsLoading,
    required bool isPatchNotesLoading,
  }) {
    return switch ((
      isAssetsLoading,
      isBaseItemsLoading,
      isFullItemsLoading,
      isPatchNotesLoading
    )) {
      (false, false, false, false) => () => context
        ..read<CheckAssetsBloc>().add(const CheckAssetsStartEvent())
        ..read<CheckBaseItemsBloc>().add(const CheckDatabaseStartEvent())
        ..read<CheckFullItemsBloc>().add(const CheckDatabaseStartEvent())
        ..read<CheckPatchNotesBloc>().add(const CheckDatabaseStartEvent()),
      (_, _, _, _) => null,
    };
  }
}

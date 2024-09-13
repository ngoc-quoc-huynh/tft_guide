import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/check_data/bloc.dart';
import 'package:tft_guide/injector.dart';

class SettingsCheckStartButton extends StatelessWidget {
  const SettingsCheckStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CheckAssetsBloc, CheckDataState, bool>(
      selector: (state) => state is CheckDataLoadInProgress,
      builder: (context, isAssetsLoading) =>
          BlocSelector<CheckBaseItemsBloc, CheckDataState, bool>(
        selector: (state) => state is CheckDataLoadInProgress,
        builder: (context, isBaseItemsLoading) =>
            BlocSelector<CheckFullItemsBloc, CheckDataState, bool>(
          selector: (state) => state is CheckDataLoadInProgress,
          builder: (context, isFullItemsLoading) =>
              BlocSelector<CheckPatchNotesBloc, CheckDataState, bool>(
            selector: (state) => state is CheckDataLoadInProgress,
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
        ..read<CheckAssetsBloc>().add(const CheckDataStartEvent())
        ..read<CheckBaseItemsBloc>().add(const CheckDataStartEvent())
        ..read<CheckFullItemsBloc>().add(const CheckDataStartEvent())
        ..read<CheckPatchNotesBloc>().add(const CheckDataStartEvent()),
      (_, _, _, _) => null,
    };
  }
}

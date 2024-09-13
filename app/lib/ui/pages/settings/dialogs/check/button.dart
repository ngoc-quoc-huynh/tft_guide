import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/check_data/bloc.dart';
import 'package:tft_guide/injector.dart';

class SettingsCheckStartButton extends StatelessWidget {
  const SettingsCheckStartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckAssetsBloc, CheckDataState>(
      builder: (context, assetsState) =>
          BlocBuilder<CheckBaseItemsBloc, CheckDataState>(
        builder: (context, baseItemsState) =>
            BlocBuilder<CheckFullItemsBloc, CheckDataState>(
          builder: (context, fullItemsState) =>
              BlocBuilder<CheckPatchNotesBloc, CheckDataState>(
            builder: (context, patchNotesState) => FilledButton(
              onPressed: _onPressed(
                context: context,
                assetsState: assetsState,
                baseItemsState: baseItemsState,
                fullItemsState: fullItemsState,
                patchNotesState: patchNotesState,
              ),
              child: switch ((
                assetsState,
                baseItemsState,
                fullItemsState,
                patchNotesState
              )) {
                (
                  CheckDataLoadOnSuccess(),
                  CheckDataLoadOnSuccess(),
                  CheckDataLoadOnSuccess(),
                  CheckDataLoadOnSuccess(),
                ) =>
                  const Icon(Icons.check),
                (_, _, _, _) => Text(
                    Injector.instance.translations.pages.settings.check.button,
                  ),
              },
            ),
          ),
        ),
      ),
    );
  }

  VoidCallback? _onPressed({
    required BuildContext context,
    required CheckDataState assetsState,
    required CheckDataState baseItemsState,
    required CheckDataState fullItemsState,
    required CheckDataState patchNotesState,
  }) {
    return switch ((
      assetsState,
      baseItemsState,
      fullItemsState,
      patchNotesState
    )) {
      (
        CheckDataInitial(),
        CheckDataInitial(),
        CheckDataInitial(),
        CheckDataInitial()
      ) =>
        () => context
          ..read<CheckAssetsBloc>().add(const CheckDataStartEvent())
          ..read<CheckBaseItemsBloc>().add(const CheckDataStartEvent())
          ..read<CheckFullItemsBloc>().add(const CheckDataStartEvent())
          ..read<CheckPatchNotesBloc>().add(const CheckDataStartEvent()),
      (
        CheckDataLoadOnSuccess(),
        CheckDataLoadOnSuccess(),
        CheckDataLoadOnSuccess(),
        CheckDataLoadOnSuccess(),
      ) =>
        () => context.pop(),
      (_, _, _, _) => null
    };
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/check_data/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/ui/widgets/loading_indicator.dart';

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
              child: _Content(
                assetsState: assetsState,
                baseItemsState: baseItemsState,
                fullItemsState: fullItemsState,
                patchNotesState: patchNotesState,
              ),
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
        CheckDataLoadOnValid(),
        CheckDataLoadOnValid(),
        CheckDataLoadOnValid(),
        CheckDataLoadOnValid(),
      ) =>
        () => context.pop(),
      (CheckDataLoadInProgress(), _, _, _) ||
      (_, CheckDataLoadInProgress(), _, _) ||
      (_, _, CheckDataLoadInProgress(), _) ||
      (_, _, _, CheckDataLoadInProgress()) =>
        null,
      (_, _, _, _) => () => context
        ..read<CheckAssetsBloc>().add(const CheckDataStartEvent())
        ..read<CheckBaseItemsBloc>().add(const CheckDataStartEvent())
        ..read<CheckFullItemsBloc>().add(const CheckDataStartEvent())
        ..read<CheckPatchNotesBloc>().add(const CheckDataStartEvent()),
    };
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.assetsState,
    required this.baseItemsState,
    required this.fullItemsState,
    required this.patchNotesState,
  });

  final CheckDataState assetsState;
  final CheckDataState baseItemsState;
  final CheckDataState fullItemsState;
  final CheckDataState patchNotesState;

  @override
  Widget build(BuildContext context) {
    return switch ((
      assetsState,
      baseItemsState,
      fullItemsState,
      patchNotesState
    )) {
      (
        CheckDataLoadOnValid(),
        CheckDataLoadOnValid(),
        CheckDataLoadOnValid(),
        CheckDataLoadOnValid(),
      ) =>
        const Icon(Icons.check),
      (CheckDataLoadInProgress(), _, _, _) ||
      (_, CheckDataLoadInProgress(), _, _) ||
      (_, _, CheckDataLoadInProgress(), _) ||
      (_, _, _, CheckDataLoadInProgress()) =>
        SizedBox.square(
          dimension: IconTheme.of(context).size,
          child: const LoadingIndicator(),
        ),
      (CheckDataLoadOnInvalid(), _, _, _) ||
      (_, CheckDataLoadOnInvalid(), _, _) ||
      (_, _, CheckDataLoadOnInvalid(), _) ||
      (_, _, _, CheckDataLoadOnInvalid()) ||
      (CheckDataLoadOnFailure(), _, _, _) ||
      (_, CheckDataLoadOnFailure(), _, _) ||
      (_, _, CheckDataLoadOnFailure(), _) ||
      (_, _, _, CheckDataLoadOnFailure()) =>
        Text(_translations.retry),
      (_, _, _, _) => Text(
          _translations.start,
        ),
    };
  }

  TranslationsPagesSettingsCheckEn get _translations =>
      Injector.instance.translations.pages.settings.check;
}

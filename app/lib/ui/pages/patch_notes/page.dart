import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/patch_notes/bloc.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/patch_notes/body.dart';
import 'package:tft_guide/ui/widgets/error_text.dart';
import 'package:tft_guide/ui/widgets/language/listener.dart';
import 'package:tft_guide/ui/widgets/loading_indicator.dart';

class PatchNotesPage extends StatelessWidget {
  const PatchNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatchNotesBloc>(
      create: (_) => PatchNotesBloc(Injector.instance.patchNotesPageSize)
        ..add(const PatchNotesInitializeEvent()),
      child: Builder(
        builder: (context) => LanguageListener(
          onLanguageChanged: (languageCode) =>
              _onLanguageChanged(context, languageCode),
          child: BlocBuilder<PatchNotesBloc, PatchNotesState>(
            builder: (context, state) => switch (state) {
              PatchNotesLoadInProgress() => const LoadingIndicator(),
              PatchNotesLoadOnSuccess(:final patchNotes)
                  when patchNotes.isEmpty =>
                const _Error(),
              PatchNotesLoadOnSuccess(
                :final patchNotes,
                :final isLastPage,
              ) =>
                PatchNotesBody(
                  patchNotes: patchNotes,
                  isLastPage: isLastPage,
                  hasError: state is PatchNotesPaginationOnFailure,
                ),
              PatchNotesLoadOnFailure() => const _Error(),
            },
          ),
        ),
      ),
    );
  }

  void _onLanguageChanged(BuildContext context, LanguageCode languageCode) =>
      context
          .read<PatchNotesBloc>()
          .add(PatchNotesChangeLanguageEvent(languageCode));
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.horizontalPadding,
      ),
      child: Center(
        child: ErrorText(
          text: Injector.instance.translations.pages.patchNotes.errors.empty,
        ),
      ),
    );
  }
}

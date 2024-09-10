import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/blocs/patch_notes/bloc.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/static/config.dart';
import 'package:tft_guide/ui/pages/patch_notes/body.dart';
import 'package:tft_guide/ui/pages/patch_notes/loading_indicator.dart';
import 'package:tft_guide/ui/widgets/language/listener.dart';

class PatchNotesPage extends StatelessWidget {
  const PatchNotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatchNotesBloc>(
      create: (_) => PatchNotesBloc(Config.patchNotesPageSize)
        ..add(const PatchNotesInitializeEvent()),
      child: Builder(
        builder: (context) => LanguageListener(
          onLanguageChanged: (languageCode) =>
              _onLanguageChanged(context, languageCode),
          child: BlocBuilder<PatchNotesBloc, PatchNotesState>(
            builder: (context, state) => switch (state) {
              PatchNotesLoadInProgress() => const PatchNotesLoadingIndicator(),
              PatchNotesLoadOnSuccess(
                :final patchNotes,
                :final isLastPage,
              ) =>
                PatchNotesBody(
                  patchNotes: patchNotes,
                  isLastPage: isLastPage,
                )
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

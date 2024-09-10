import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/patch_note.dart';
import 'package:tft_guide/domain/utils/extensions/bloc.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'state.dart';

final class PatchNotesBloc extends Bloc<PatchNotesEvent, PatchNotesState> {
  PatchNotesBloc(this._pageSize) : super(const PatchNotesLoadInProgress()) {
    on<PatchNotesInitializeEvent>(
      _onPatchNotesInitializeEvent,
      transformer: droppable(),
    );
    on<PatchNotesLoadMoreEvent>(
      _onPatchNotesLoadMoreEvent,
      transformer: debounce(),
    );
    on<PatchNotesChangeLanguageEvent>(
      _onPatchNotesChangeLanguageEvent,
      transformer: restartable(),
    );
  }

  final int _pageSize;
  static final _localDatabaseApi = Injector.instance.localDatabaseApi;

  static LanguageCode get _languageCode => Injector.instance.languageCode;

  Future<void> _onPatchNotesInitializeEvent(
    PatchNotesInitializeEvent event,
    Emitter<PatchNotesState> emit,
  ) async {
    const currentPage = 0;
    final paginatedPatchNotes = await _localDatabaseApi.loadPatchNotes(
      currentPage: currentPage,
      pageSize: _pageSize,
      languageCode: _languageCode,
    );

    emit(
      PatchNotesPaginationOnSuccess(
        currentPage: currentPage,
        patchNotes: paginatedPatchNotes.patchNotes,
        isLastPage: _isLastPage(currentPage, paginatedPatchNotes.totalPages),
      ),
    );
  }

  Future<void> _onPatchNotesLoadMoreEvent(
    PatchNotesLoadMoreEvent event,
    Emitter<PatchNotesState> emit,
  ) async {
    if (state
        case PatchNotesLoadOnSuccess(
          :final currentPage,
          :final patchNotes,
          :final isLastPage
        ) when !isLastPage) {
      final newPage = currentPage + 1;
      final paginatedPatchNotes = await _localDatabaseApi.loadPatchNotes(
        currentPage: newPage,
        pageSize: _pageSize,
        languageCode: _languageCode,
      );
      emit(
        PatchNotesPaginationOnSuccess(
          currentPage: newPage,
          patchNotes: [...patchNotes, ...paginatedPatchNotes.patchNotes],
          isLastPage: _isLastPage(newPage, paginatedPatchNotes.totalPages),
        ),
      );
    }
  }

  Future<void> _onPatchNotesChangeLanguageEvent(
    PatchNotesChangeLanguageEvent event,
    Emitter<PatchNotesState> emit,
  ) async {
    const currentPage = 0;
    final paginatedPatchNotes = await _localDatabaseApi.loadPatchNotes(
      currentPage: currentPage,
      pageSize: _pageSize,
      languageCode: event.languageCode,
    );

    emit(
      PatchNotesChangeLocaleOnSuccess(
        currentPage: currentPage,
        patchNotes: paginatedPatchNotes.patchNotes,
        isLastPage: _isLastPage(currentPage, paginatedPatchNotes.totalPages),
      ),
    );
  }

  bool _isLastPage(int currentPage, int totalPages) =>
      currentPage == totalPages - 1;
}
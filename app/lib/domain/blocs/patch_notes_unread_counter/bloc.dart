import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'state.dart';

final class PatchNotesUnreadCounterBloc
    extends Bloc<PatchNotesUnreadCounterEvent, PatchNotesUnreadCounterState> {
  PatchNotesUnreadCounterBloc()
      : super(const PatchNotesUnreadCounterLoadInProgress()) {
    on<PatchNotesUnreadCounterInitializeEvent>(
      _onPatchNotesUnreadCounterInitializeEvent,
    );
    on<PatchNotesUnreadCounterReadEvent>(_onPatchNotesUnreadCounterReadEvent);
  }

  static final _localDatabaseApi = Injector.instance.localDatabaseApi;
  static final _localStorageApi = Injector.instance.localStorageApi;

  Future<void> _onPatchNotesUnreadCounterInitializeEvent(
    PatchNotesUnreadCounterInitializeEvent event,
    Emitter<PatchNotesUnreadCounterState> emit,
  ) async {
    final totalCount = await _localDatabaseApi.loadPatchNotesCount();
    emit(
      PatchNotesUnreadCounterLoadOnSuccess(
        unreadCount: totalCount - _localStorageApi.readPatchNotesCount,
        totalCount: totalCount,
      ),
    );
  }

  Future<void> _onPatchNotesUnreadCounterReadEvent(
    PatchNotesUnreadCounterReadEvent event,
    Emitter<PatchNotesUnreadCounterState> emit,
  ) async {
    if (state
        case PatchNotesUnreadCounterLoadOnSuccess(
          :final unreadCount,
          :final totalCount
        ) when unreadCount != 0) {
      await _localStorageApi.updateReadPatchNotesCount(totalCount);
      emit(
        PatchNotesUnreadCounterLoadOnSuccess(
          unreadCount: 0,
          totalCount: totalCount,
        ),
      );
    }
  }
}

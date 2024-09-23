import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/utils/mixins/bloc.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'state.dart';

final class PatchNotesUnreadCounterBloc
    extends Bloc<PatchNotesUnreadCounterEvent, PatchNotesUnreadCounterState>
    with BlocMixin {
  PatchNotesUnreadCounterBloc()
      : super(const PatchNotesUnreadCounterLoadInProgress()) {
    on<PatchNotesUnreadCounterInitializeEvent>(
      _onPatchNotesUnreadCounterInitializeEvent,
      transformer: droppable(),
    );
    on<PatchNotesUnreadCounterReadEvent>(
      _onPatchNotesUnreadCounterReadEvent,
      transformer: droppable(),
    );
  }

  static final _localDatabaseApi = Injector.instance.localDatabaseApi;
  static final _localStorageApi = Injector.instance.localStorageApi;

  Future<void> _onPatchNotesUnreadCounterInitializeEvent(
    PatchNotesUnreadCounterInitializeEvent event,
    Emitter<PatchNotesUnreadCounterState> emit,
  ) =>
      executeSafely(
        methodName: 'PatchNotesUnreadCounterBloc.'
            '_onPatchNotesUnreadCounterInitializeEvent',
        function: () async {
          final totalCount = await _localDatabaseApi.loadPatchNotesCount();
          emit(
            PatchNotesUnreadCounterLoadOnSuccess(
              unreadCount: totalCount - _localStorageApi.readPatchNotesCount,
              totalCount: totalCount,
            ),
          );
        },
        onError: () => emit(
          const PatchNotesUnreadCounterLoadOnSuccess(
            unreadCount: 0,
            totalCount: 0,
          ),
        ),
      );

  Future<void> _onPatchNotesUnreadCounterReadEvent(
    PatchNotesUnreadCounterReadEvent event,
    Emitter<PatchNotesUnreadCounterState> emit,
  ) async {
    if (state
        case PatchNotesUnreadCounterLoadOnSuccess(
          :final unreadCount,
          :final totalCount
        ) when unreadCount != 0) {
      final resultState = PatchNotesUnreadCounterLoadOnSuccess(
        unreadCount: 0,
        totalCount: totalCount,
      );
      await executeSafely(
        methodName: 'PatchNotesUnreadCounterBloc.'
            '_onPatchNotesUnreadCounterReadEvent',
        function: () async {
          await _localStorageApi.updateReadPatchNotesCount(totalCount);
          emit(resultState);
        },
        onError: () => emit(resultState),
      );
    }
  }
}

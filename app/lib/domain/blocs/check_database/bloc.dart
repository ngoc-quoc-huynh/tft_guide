import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/injector.dart';

part 'base_items/bloc.dart';
part 'event.dart';
part 'full_items/bloc.dart';
part 'patch_notes/bloc.dart';
part 'state.dart';

sealed class CheckDatabaseBloc
    extends Bloc<CheckBaseItemsEvent, CheckDatabaseState> {
  CheckDatabaseBloc({
    required this.loadLocalDataCount,
    required this.loadRemoteDataCount,
    required this.loadLocalTranslationCount,
    required this.loadRemoteTranslationCount,
  }) : super(const CheckDatabaseInitial()) {
    on<CheckDatabaseStartEvent>(_onCheckDatabaseStartEvent);
  }

  final Future<int> Function() loadLocalDataCount;
  final Future<int> Function() loadRemoteDataCount;
  final Future<int> Function() loadLocalTranslationCount;
  final Future<int> Function() loadRemoteTranslationCount;

  @protected
  static final localDatabaseApi = Injector.instance.localDatabaseApi;
  @protected
  static final remoteDatabaseApi = Injector.instance.remoteDatabaseApi;

  Future<void> _onCheckDatabaseStartEvent(
    CheckDatabaseStartEvent event,
    Emitter<CheckDatabaseState> emit,
  ) async {
    emit(const CheckDatabaseLoadInProgress());
    final (
      localDataCountCount,
      remoteDataCount,
      localTranslationCount,
      remoteTranslationCount,
    ) = await (
      loadLocalDataCount(),
      loadRemoteDataCount(),
      loadLocalTranslationCount(),
      loadRemoteTranslationCount(),
    ).wait;
    final success = localDataCountCount == remoteDataCount &&
        localTranslationCount == remoteTranslationCount;
    emit(CheckDatabaseLoadOnSuccess(success: success));
  }
}

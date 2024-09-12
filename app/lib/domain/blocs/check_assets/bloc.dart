import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'state.dart';

final class CheckAssetsBloc extends Bloc<CheckAssetsEvent, CheckAssetsState> {
  CheckAssetsBloc() : super(const CheckAssetsInitial()) {
    on<CheckAssetsStartEvent>(_onCheckAssetsStartEvent);
  }

  static final _fileStorageApi = Injector.instance.fileStorageApi;
  static final _remoteDatabaseApi = Injector.instance.remoteDatabaseApi;

  Future<void> _onCheckAssetsStartEvent(
    CheckAssetsStartEvent event,
    Emitter<CheckAssetsState> emit,
  ) async {
    emit(const CheckAssetsLoadInProgress());
    final localCount = _fileStorageApi.loadAssetsCount();
    final remoteCount = await _remoteDatabaseApi.loadAssetsCount();
    emit(CheckAssetsLoadOnSuccess(success: localCount == remoteCount));
  }
}

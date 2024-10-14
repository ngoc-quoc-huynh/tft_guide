import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/utils/mixins/bloc.dart';
import 'package:tft_guide/injector.dart';

part 'event.dart';
part 'state.dart';

final class AppUpdateBloc extends Bloc<AppUpdateEvent, AppUpdateState>
    with BlocMixin {
  AppUpdateBloc(this._version) : super(const AppUpdateInitial()) {
    on<AppUpdateInitializeEvent>(
      _onAppUpdateInitializeEvent,
      transformer: droppable(),
    );
  }

  final String _version;

  static final _appApi = Injector.instance.appApi;

  Future<void> _onAppUpdateInitializeEvent(
    AppUpdateInitializeEvent event,
    Emitter<AppUpdateState> emit,
  ) =>
      executeSafely(
        methodName: 'AppUpdateBloc._onAppUpdateInitializeEvent',
        function: () async {
          emit(const AppUpdateLoadInProgress(0));
          final path = await _appApi.downloadAppUpdate(
            _version,
            onReceiveProgress: (current, total) =>
                emit(AppUpdateLoadInProgress(current / total * 100)),
          );
          emit(AppUpdateLoadOnSuccess(path));
        },
        onError: () => emit(const AppUpdateLoadOnFailure()),
      );
}

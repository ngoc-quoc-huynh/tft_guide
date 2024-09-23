import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/utils/mixins/bloc.dart';
import 'package:tft_guide/injector.dart';

part 'assets/bloc.dart';
part 'assets/state.dart';
part 'database/base_items/bloc.dart';
part 'database/bloc.dart';
part 'database/full_items/bloc.dart';
part 'database/patch_notes/bloc.dart';
part 'database/state.dart';
part 'event.dart';
part 'state.dart';

sealed class CheckDataBloc extends Bloc<CheckDataEvent, CheckDataState>
    with BlocMixin {
  CheckDataBloc(this._className, this._computeSuccessState)
      : super(const CheckDataInitial()) {
    on<CheckDataStartEvent>(
      onCheckDataStartEvent,
      transformer: droppable(),
    );
  }

  final String _className;
  final Future<CheckDataLoadOnSuccess> Function() _computeSuccessState;

  Future<void> onCheckDataStartEvent(
    _,
    Emitter<CheckDataState> emit,
  ) async =>
      executeSafely(
        methodName: '$_className.onCheckDataStartEvent',
        function: () async {
          emit(const CheckDataLoadInProgress());
          emit(await _computeSuccessState());
        },
        onError: () => emit(const CheckDataLoadOnFailure()),
      );
}

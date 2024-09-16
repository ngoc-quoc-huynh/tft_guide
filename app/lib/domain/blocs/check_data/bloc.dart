import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

sealed class CheckDataBloc extends Bloc<CheckDataEvent, CheckDataState> {
  CheckDataBloc(this.computeSuccessState) : super(const CheckDataInitial()) {
    on<CheckDataStartEvent>(onCheckDataStartEvent);
  }

  final Future<CheckDataLoadOnSuccess> Function() computeSuccessState;

  Future<void> onCheckDataStartEvent(
    _,
    Emitter<CheckDataState> emit,
  ) async {
    emit(const CheckDataLoadInProgress());
    try {
      emit(await computeSuccessState());
    } on Exception {
      emit(const CheckDataLoadOnFailure());
    }
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/injector.dart';

part 'assets/bloc.dart';
part 'database/base_items/bloc.dart';
part 'database/bloc.dart';
part 'database/full_items/bloc.dart';
part 'database/patch_notes/bloc.dart';
part 'event.dart';
part 'state.dart';

sealed class CheckDataBloc extends Bloc<CheckDataEvent, CheckDataState> {
  CheckDataBloc(this._compareCounts) : super(const CheckDataInitial()) {
    on<CheckDataStartEvent>(_onCheckDataStartEvent);
  }

  final Future<bool> Function() _compareCounts;

  Future<void> _onCheckDataStartEvent(
    CheckDataStartEvent event,
    Emitter<CheckDataState> emit,
  ) async {
    emit(const CheckDataLoadInProgress());

    emit(
      CheckDataLoadOnSuccess(
        success: await _compareCounts(),
      ),
    );
  }
}

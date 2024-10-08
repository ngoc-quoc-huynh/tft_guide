import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'state.dart';

final class StepTimerCubit extends Cubit<StepTimerState> {
  StepTimerCubit(this._maxSteps) : super(const StepTimerInitial());

  final int _maxSteps;

  Timer? _timer;

  void advance() => switch (state) {
        StepTimerInitial() ||
        StepTimerCompleted() when _maxSteps == 1 =>
          _handleCompletion(),
        StepTimerInitial() || StepTimerCompleted() => _incrementStep(0),
        StepTimerInProgress(step: final step) when step == _maxSteps - 1 =>
          _handleCompletion(),
        StepTimerInProgress(step: final step) => _incrementStep(step),
      };

  void _incrementStep(int step) {
    _startTimer();
    emit(StepTimerInProgress(step + 1));
  }

  void _handleCompletion() {
    emit(const StepTimerCompleted());
    emit(const StepTimerInitial());
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _startTimer() {
    _cancelTimer();
    _timer = Timer(
      const Duration(seconds: 1),
      () => emit(const StepTimerInitial()),
    );
  }

  @override
  Future<void> close() {
    _cancelTimer();
    return super.close();
  }
}

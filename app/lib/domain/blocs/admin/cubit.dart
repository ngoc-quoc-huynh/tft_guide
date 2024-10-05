import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'state.dart';

final class AdminCubit extends Cubit<AdminState> {
  AdminCubit(this._amountOfClicksToEnableAdmin) : super(const AdminDisabled());

  final int _amountOfClicksToEnableAdmin;

  Timer? _timer;

  void click() => switch (state) {
        AdminEnabled() => null,
        AdminLoadInProgress(amountOfClicks: final amountOfClicks)
            when amountOfClicks == _amountOfClicksToEnableAdmin - 1 =>
          _activeAdminMode(),
        AdminLoadInProgress(amountOfClicks: final amountOfClicks) =>
          _handleAdminModeInProgress(amountOfClicks),
        AdminDisabled() => _initializeAdminMode(),
      };

  void _activeAdminMode() {
    _cancelTimer();
    emit(const AdminEnabled());
  }

  void _handleAdminModeInProgress(int amountOfClicks) {
    _startTimer();
    emit(AdminLoadInProgress(amountOfClicks + 1));
  }

  void _initializeAdminMode() {
    _startTimer();
    emit(const AdminLoadInProgress(1));
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _startTimer() {
    _cancelTimer();
    _timer = Timer(
      const Duration(seconds: 1),
      () => emit(const AdminDisabled()),
    );
  }

  @override
  Future<void> close() {
    _cancelTimer();
    return super.close();
  }
}

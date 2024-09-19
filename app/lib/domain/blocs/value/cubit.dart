import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';

part 'types.dart';
part 'state.dart';

final class ValueCubit<State> extends Cubit<State> {
  ValueCubit(super.initialState);

  void update(State newState) => emit(newState);
}

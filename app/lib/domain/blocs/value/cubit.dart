import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/injector.dart';

part 'language_code/cubit.dart';
part 'num/cubit.dart';
part 'selection/cubit.dart';
part 'state.dart';
part 'types.dart';

@visibleForTesting
base mixin TestValueCubitMixin<State> implements ValueCubit<State> {}

base class ValueCubit<State> extends Cubit<State> {
  ValueCubit(super.initialState);

  void update(State newState) => emit(newState);
}

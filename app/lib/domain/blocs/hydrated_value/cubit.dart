import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';

part 'theme_mode/cubit.dart';
part 'translation_locale/cubit.dart';

sealed class HydratedValueCubit<State> extends HydratedCubit<State> {
  HydratedValueCubit(super.state);

  void update(State language) => emit(language);
}

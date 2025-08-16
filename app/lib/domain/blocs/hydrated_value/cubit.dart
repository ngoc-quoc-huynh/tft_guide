import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';

part 'elo/cubit.dart';
part 'theme_mode/cubit.dart';
part 'translation_locale/cubit.dart';

sealed class HydratedValueCubit<T> extends HydratedCubit<T> {
  HydratedValueCubit(super.state);

  void update(T language) => emit(language);
}

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

final class ThemeModeCubit extends HydratedCubit<ThemeMode> {
  ThemeModeCubit() : super(ThemeMode.system);

  void change(ThemeMode mode) => emit(mode);

  @override
  ThemeMode fromJson(Map<String, dynamic> json) =>
      ThemeMode.values.byName(json['theme_mode'] as String);

  @override
  Map<String, dynamic>? toJson(ThemeMode state) => {
        'theme_mode': state.name,
      };
}

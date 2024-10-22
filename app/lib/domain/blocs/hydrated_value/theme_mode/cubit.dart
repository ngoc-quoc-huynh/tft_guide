part of '../cubit.dart';

@visibleForTesting
base mixin TestHydratedThemeModeCubitMixin implements HydratedThemeModeCubit {}

final class HydratedThemeModeCubit extends HydratedValueCubit<ThemeMode> {
  HydratedThemeModeCubit() : super(ThemeMode.system);

  @override
  ThemeMode fromJson(Map<String, dynamic> json) =>
      ThemeMode.values.byName(json['theme_mode'] as String);

  @override
  Map<String, dynamic>? toJson(ThemeMode state) => {
        'theme_mode': state.name,
      };
}

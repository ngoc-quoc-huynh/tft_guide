part of '../cubit.dart';

final class HydratedTranslationLocaleCubit
    extends HydratedValueCubit<TranslationLocale> {
  HydratedTranslationLocaleCubit() : super(TranslationLocale.system);

  @override
  TranslationLocale fromJson(Map<String, dynamic> json) =>
      TranslationLocale.values.byName(json['language'] as String);

  @override
  Map<String, dynamic>? toJson(TranslationLocale? state) => {
        'language': state?.name,
      };
}
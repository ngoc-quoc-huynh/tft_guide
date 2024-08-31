import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';

final class TranslationLocaleCubit extends HydratedCubit<TranslationLocale> {
  TranslationLocaleCubit() : super(TranslationLocale.system);

  void change(TranslationLocale language) => emit(language);

  @override
  TranslationLocale? fromJson(Map<String, dynamic> json) =>
      TranslationLocale.values.byName(json['language'] as String);

  @override
  Map<String, dynamic>? toJson(TranslationLocale? state) => {
        'language': state?.name,
      };
}

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

final class TranslationLocaleCubit extends HydratedCubit<TranslationLocale> {
  TranslationLocaleCubit() : super(TranslationLocale.system) {
    Injector.instance.registerLazySingleton<Translations>(
      () => _computeTranslations(state),
    );
  }

  static final _widgetsBindingApi = Injector.instance.widgetsBindingApi;

  void change(TranslationLocale language) {
    Injector.instance
      // ignore: discarded_futures, since this is not a future and we cannot use unawaited.
      ..unregister<Translations>()
      ..registerLazySingleton<Translations>(
        () => _computeTranslations(language),
      );
    emit(language);
  }

  @override
  TranslationLocale? fromJson(Map<String, dynamic> json) =>
      TranslationLocale.values.byName(json['language'] as String);

  @override
  Map<String, dynamic>? toJson(TranslationLocale? state) => {
        'language': state?.name,
      };

  Translations _computeTranslations(TranslationLocale language) =>
      switch ((language, _widgetsBindingApi.locale.languageCode)) {
        (TranslationLocale.system, final code) when code.startsWith('de') =>
          AppLocale.de,
        (TranslationLocale.system, final code) when code.startsWith('en') =>
          AppLocale.en,
        (TranslationLocale.german, _) => AppLocale.de,
        (TranslationLocale.english, _) || (_, _) => AppLocale.en,
      }
          .build();
}

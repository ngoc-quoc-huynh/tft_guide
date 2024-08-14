import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

final class TranslationLocaleCubit extends HydratedCubit<TranslationLocale?> {
  TranslationLocaleCubit() : super(null) {
    Injector.instance.registerLazySingleton<Translations>(
      () => _computeTranslations(state),
    );
  }

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

  Translations _computeTranslations(TranslationLocale? language) {
    final localCountryCode =
        LocaleSettings.instance.utils.findDeviceLocale().countryCode;
    return switch ((language, localCountryCode)) {
      (TranslationLocale.german, _) ||
      (TranslationLocale.system, 'de') ||
      (null, 'de') =>
        AppLocale.de,
      (TranslationLocale.english, _) ||
      (TranslationLocale.system, 'en') ||
      (null, 'en') ||
      (_, _) =>
        AppLocale.en,
    }
        .build();
  }
}

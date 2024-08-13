import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tft_guide/domain/models/language.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

final class LanguageCubit extends HydratedCubit<Language?> {
  LanguageCubit() : super(null) {
    Injector.instance.registerLazySingleton<Translations>(
      () => _computeTranslations(state),
    );
  }

  void change(Language language) {
    Injector.instance
      // ignore: discarded_futures, since this is not a future and we cannot use unawaited.
      ..unregister<Translations>()
      ..registerLazySingleton<Translations>(
        () => _computeTranslations(language),
      );
    emit(language);
  }

  @override
  Language? fromJson(Map<String, dynamic> json) =>
      Language.values.byName(json['language'] as String);

  @override
  Map<String, dynamic>? toJson(Language? state) => {
        'language': state?.name,
      };

  Translations _computeTranslations(Language? language) {
    final localCountryCode =
        LocaleSettings.instance.utils.findDeviceLocale().countryCode;
    return switch ((language, localCountryCode)) {
      (Language.german, _) ||
      (Language.system, 'de') ||
      (null, 'de') =>
        AppLocale.de,
      (Language.english, _) ||
      (Language.system, 'en') ||
      (null, 'en') ||
      (_, _) =>
        AppLocale.en,
    }
        .build();
  }
}

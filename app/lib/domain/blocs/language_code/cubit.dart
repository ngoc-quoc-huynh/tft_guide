import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

final class LanguageCodeCubit extends Cubit<LanguageCode> {
  LanguageCodeCubit(super.initialState) {
    Injector.instance.registerLazySingleton<Translations>(
      () => _computeTranslations(state),
    );
  }

  void update(LanguageCode languageCode) {
    Injector.instance
      // ignore: discarded_futures, since this is not a future and we cannot use unawaited.
      ..unregister<Translations>()
      ..registerLazySingleton<Translations>(
        () => _computeTranslations(languageCode),
      );
    emit(languageCode);
  }

  Translations _computeTranslations(LanguageCode language) =>
      switch (language) {
        LanguageCode.de => AppLocale.de,
        LanguageCode.en => AppLocale.en,
      }
          .build();
}

part of '../cubit.dart';

final class LanguageCodeValueCubit extends ValueCubit<LanguageCode> {
  LanguageCodeValueCubit(super.initialState) {
    Injector.instance.registerLazySingleton<Translations>(
      () => _computeTranslations(state),
    );
  }

  @override
  void update(LanguageCode newState) {
    Injector.instance
      // ignore: discarded_futures, since this is not a future and we cannot use unawaited.
      ..unregister<Translations>()
      ..registerLazySingleton<Translations>(
        () => _computeTranslations(newState),
      );

    return super.update(newState);
  }

  Translations _computeTranslations(LanguageCode language) =>
      switch (language) {
        LanguageCode.de => AppLocale.de,
        LanguageCode.en => AppLocale.en,
      }
          .build();
}

enum TranslationLocale {
  german('de'),
  english('en'),
  system(null);

  const TranslationLocale(this.code);

  factory TranslationLocale.byLanguageCode(String code) => switch (code) {
        String() when code.startsWith('de') => TranslationLocale.german,
        String() when code.startsWith('en') => TranslationLocale.english,
        String() => TranslationLocale.english,
      };

  final String? code;
}

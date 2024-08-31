enum LanguageCode {
  de,
  en;

  factory LanguageCode.byLanguageCode(String code) => switch (code) {
        String() when code.startsWith('de') => LanguageCode.de,
        String() when code.startsWith('en') => LanguageCode.en,
        String() => LanguageCode.en,
      };
}

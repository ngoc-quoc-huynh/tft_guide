enum Language {
  german('de'),
  english('en'),
  system(null);

  const Language(this.code);

  final String? code;
}

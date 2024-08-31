import 'package:tft_guide/domain/models/database/language_code.dart' as domain;

enum LanguageCode {
  de,
  en;

  domain.LanguageCode toDomain() => domain.LanguageCode.values.byName(name);
}

import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/database/language_code.dart' as domain;
import 'package:tft_guide/infrastructure/dtos/supabase/language_code.dart';

void main() {
  group('toDomain', () {
    test('returns correctly.', () {
      expect(LanguageCode.de.toDomain(), domain.LanguageCode.de);
      expect(LanguageCode.en.toDomain(), domain.LanguageCode.en);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';

void main() {
  group('byLanguageCode', () {
    test(
      'returns de.',
      () {
        expect(
          LanguageCode.byLanguageCode('de'),
          LanguageCode.de,
        );
        expect(
          LanguageCode.byLanguageCode('de-at'),
          LanguageCode.de,
        );
        expect(
          LanguageCode.byLanguageCode('de-ch'),
          LanguageCode.de,
        );
        expect(
          LanguageCode.byLanguageCode('de-li'),
          LanguageCode.de,
        );
        expect(
          LanguageCode.byLanguageCode('de-lu'),
          LanguageCode.de,
        );
      },
    );
    test('returns en when code starts with en.', () {
      expect(
        LanguageCode.byLanguageCode('en'),
        LanguageCode.en,
      );
      expect(
        LanguageCode.byLanguageCode('en-au'),
        LanguageCode.en,
      );
      expect(
        LanguageCode.byLanguageCode('en-bz'),
        LanguageCode.en,
      );
      expect(
        LanguageCode.byLanguageCode('en-ca'),
        LanguageCode.en,
      );
      expect(
        LanguageCode.byLanguageCode('en-ie'),
        LanguageCode.en,
      );
      expect(
        LanguageCode.byLanguageCode('en-jm'),
        LanguageCode.en,
      );
      expect(
        LanguageCode.byLanguageCode('en-nz'),
        LanguageCode.en,
      );
      expect(
        LanguageCode.byLanguageCode('en-za'),
        LanguageCode.en,
      );
      expect(
        LanguageCode.byLanguageCode('en-tt'),
        LanguageCode.en,
      );
      expect(
        LanguageCode.byLanguageCode('en-gb'),
        LanguageCode.en,
      );
      expect(
        LanguageCode.byLanguageCode('en-us'),
        LanguageCode.en,
      );
    });

    test('returns en', () {
      expect(
        LanguageCode.byLanguageCode('it'),
        LanguageCode.en,
      );
      expect(
        LanguageCode.byLanguageCode('fr'),
        LanguageCode.en,
      );
    });
  });
}

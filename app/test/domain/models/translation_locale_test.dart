import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';

void main() {
  group('byLanguageCode', () {
    test(
      'returns german.',
      () {
        expect(
          TranslationLocale.byLanguageCode('de'),
          TranslationLocale.german,
        );
        expect(
          TranslationLocale.byLanguageCode('de-at'),
          TranslationLocale.german,
        );
        expect(
          TranslationLocale.byLanguageCode('de-ch'),
          TranslationLocale.german,
        );
        expect(
          TranslationLocale.byLanguageCode('de-li'),
          TranslationLocale.german,
        );
        expect(
          TranslationLocale.byLanguageCode('de-lu'),
          TranslationLocale.german,
        );
      },
    );

    test('returns english when code starts with en.', () {
      expect(
        TranslationLocale.byLanguageCode('en'),
        TranslationLocale.english,
      );
      expect(
        TranslationLocale.byLanguageCode('en-au'),
        TranslationLocale.english,
      );
      expect(
        TranslationLocale.byLanguageCode('en-bz'),
        TranslationLocale.english,
      );
      expect(
        TranslationLocale.byLanguageCode('en-ca'),
        TranslationLocale.english,
      );
      expect(
        TranslationLocale.byLanguageCode('en-ie'),
        TranslationLocale.english,
      );
      expect(
        TranslationLocale.byLanguageCode('en-jm'),
        TranslationLocale.english,
      );
      expect(
        TranslationLocale.byLanguageCode('en-nz'),
        TranslationLocale.english,
      );
      expect(
        TranslationLocale.byLanguageCode('en-za'),
        TranslationLocale.english,
      );
      expect(
        TranslationLocale.byLanguageCode('en-tt'),
        TranslationLocale.english,
      );
      expect(
        TranslationLocale.byLanguageCode('en-gb'),
        TranslationLocale.english,
      );
      expect(
        TranslationLocale.byLanguageCode('en-us'),
        TranslationLocale.english,
      );
    });

    test('returns english', () {
      expect(
        TranslationLocale.byLanguageCode('it'),
        TranslationLocale.english,
      );
      expect(
        TranslationLocale.byLanguageCode('fr'),
        TranslationLocale.english,
      );
    });
  });
}

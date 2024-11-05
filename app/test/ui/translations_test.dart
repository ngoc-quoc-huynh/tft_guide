import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

void main() {
  group('i18n', () {
    test(
      'Should compile.',
      () => expect(AppLocale.en.buildSync().appName, 'TFT Guide'),
    );

    test('All locales should be supported by Flutter.', () {
      for (final locale in AppLocale.values) {
        expect(
          kMaterialSupportedLanguages,
          contains(locale.languageCode),
        );
      }
    });
  });
}

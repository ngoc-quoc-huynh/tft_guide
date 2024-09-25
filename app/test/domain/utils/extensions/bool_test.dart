import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/utils/extensions/bool.dart';

void main() {
  group('parseInt', () {
    test(
      'returns false if int is 0.',
      () => expect(
        BoolExtension.parseInt(0),
        false,
      ),
    );

    test(
      'returns true if int is 1.',
      () => expect(
        BoolExtension.parseInt(1),
        true,
      ),
    );

    test(
      'throw FormatException if int is not 0 or 1.',
      () => expect(
        () => BoolExtension.parseInt(2),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'message',
            'Invalid boolean format.',
          ),
        ),
      ),
    );
  });
}

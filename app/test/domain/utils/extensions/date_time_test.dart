import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/utils/extensions/date_time.dart';

void main() {
  group('tryParseOrNull', () {
    test(
      'returns null if string is null.',
      () => expect(
        DateTimeExtension.tryParseOrNull(null),
        isNull,
      ),
    );

    test(
      'returns DateTime if string is not null.',
      () => expect(
        DateTimeExtension.tryParseOrNull('2024-01-01T00:00:00.000Z'),
        DateTime.utc(2024),
      ),
    );
  });

  group('isToday', () {
    test(
      'returns true if DateTime is today.',
      () => withClock(
        Clock.fixed(DateTime.utc(2024)),
        () => expect(
          DateTime.utc(2024).isToday,
          true,
        ),
      ),
    );

    test(
      'returns false if DateTime is not today.',
      () => withClock(
        Clock.fixed(DateTime.utc(2024)),
        () => expect(
          DateTime.utc(2023).isToday,
          false,
        ),
      ),
    );

    test(
      'returns false if month is different.',
      () => withClock(
        Clock.fixed(DateTime.utc(2024)),
        () => expect(
          DateTime.utc(2024, 2).isToday,
          false,
        ),
      ),
    );

    test(
      'returns false if day is different.',
      () => withClock(
        Clock.fixed(DateTime.utc(2024)),
        () => expect(
          DateTime.utc(2024, 1, 2).isToday,
          false,
        ),
      ),
    );
  });

  group('format', () {
    test(
      'returns correctly.',
      () => expect(
        DateTime.utc(2024).format(),
        '01.01.24',
      ),
    );
  });
}

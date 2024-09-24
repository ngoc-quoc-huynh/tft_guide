import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';

extension DurationTestExtension on Duration {
  Duration get withThreshold => this + const Duration(milliseconds: 50);
}

void expectList<T>(List<T> actual, List<T> matcher) => expect(
      ListEquality<T>().equals(actual, matcher),
      isTrue,
    );

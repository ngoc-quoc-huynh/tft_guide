import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';

extension DurationTestExtension on Duration {
  Duration get withThreshold => this + const Duration(milliseconds: 50);
}

void expectList<T>(List<T> actual, List<T> matcher) => expect(
      ListEquality<T>().equals(actual, matcher),
      isTrue,
    );

final class TestFile {
  const TestFile(this.path);

  final String path;

  File toFile() => File(join(Directory.current.path, 'test', path));
}

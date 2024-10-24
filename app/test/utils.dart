import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

extension WidgetTesterExtension on WidgetTester {
  T readBloc<T extends StateStreamableSource<Object?>>(Type type) =>
      BlocProvider.of<T>(
        element(find.byType(type)),
      );
}

final class CountRebuildsWidget extends StatefulWidget {
  const CountRebuildsWidget({super.key});

  @override
  State<CountRebuildsWidget> createState() => CountRebuildsWidgetState();
}

class CountRebuildsWidgetState extends State<CountRebuildsWidget> {
  @visibleForTesting
  int buildCount = 0;

  @override
  Widget build(BuildContext context) {
    buildCount++;
    return const Text('test');
  }
}

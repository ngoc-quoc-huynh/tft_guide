import 'dart:io';

import 'package:alchemist/alchemist.dart';
import 'package:collection/collection.dart';
import 'package:file/memory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';

BoxConstraints pageConstraints({
  double? width,
  double? height,
}) =>
    BoxConstraints.tightFor(width: width ?? 360, height: height ?? 640);

extension DurationTestExtension on Duration {
  Duration get withThreshold => this + const Duration(milliseconds: 50);
}

void expectList<T>(List<T> actual, List<T> matcher) => expect(
      ListEquality<T>().equals(actual, matcher),
      isTrue,
    );

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

// ignore: avoid_classes_with_only_static_members, needed to initialize the file only once.
class TestFile {
  const TestFile._();

  static final File _testFile = MemoryFileSystem().file('test.webp')
    ..writeAsBytesSync(
      File(
        join(
          Directory.current.path,
          'test',
          'assets',
          'test.webp',
        ),
      ).readAsBytesSync(),
    );

  static File get file => _testFile;
}

Interaction? tap(Finder finder) => (WidgetTester tester) async {
      for (int i = 0; i < finder.evaluate().length; i++) {
        await tester.tap(finder.at(i));
      }
      await tester.pumpAndSettle();

      return null;
    };

Future<void> pumpSingleFrameWidget(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(widget);
  await tester.pump();
}

import 'dart:io';
import 'dart:typed_data';

import 'package:file/file.dart' hide Directory;
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/interfaces/logger.dart';
import 'package:tft_guide/infrastructure/repositories/local_file_storage.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

void main() {
  final fileSystem = MemoryFileSystem();
  const repository = LocalFileStorageRepository();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Directory>(fileSystem.directory('app'))
      ..registerSingleton<FileSystem>(fileSystem)
      ..registerSingleton<LoggerApi>(MockLoggerApi()),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Directory>()
      ..unregister<FileSystem>()
      ..unregister<LoggerApi>(),
  );

  group('loadLatestFileUpdatedAt', () {
    test('returns null if asset directory does not exist.', () {
      final result = repository.loadLatestFileUpdatedAt();
      expect(result, isNull);
    });

    test('returns null if no asset files exist.', () {
      final dir = fileSystem.directory('app/assets')
        ..createSync(recursive: true);
      addTearDown(() => dir.deleteSync(recursive: true));
      final result = repository.loadLatestFileUpdatedAt();
      expect(result, isNull);
    });

    test('returns correctly if only a single file exists.', () async {
      final file = fileSystem.file('app/assets/file.webp')
        ..createSync(recursive: true);
      await file.setLastModified(DateTime.utc(2024));
      addTearDown(() => file.deleteSync(recursive: true));

      final result = repository.loadLatestFileUpdatedAt();
      expect(result, DateTime.utc(2024));
    });

    test('returns correctly if multiple files exist.', () async {
      final file1 = fileSystem.file('app/assets/file1.webp')
        ..createSync(recursive: true);
      await file1.setLastModified(DateTime.utc(2024));
      final file2 = fileSystem.file('app/assets/file2.webp')
        ..createSync(recursive: true);
      await file2.setLastModified(DateTime.utc(2023));
      addTearDown(() {
        file1.deleteSync(recursive: true);
        file2.deleteSync(recursive: true);
      });

      final result = repository.loadLatestFileUpdatedAt();
      expect(result, DateTime.utc(2024));
    });
  });

  group('save', () {
    test('returns correctly.', () async {
      final future = repository.save(
        'file.webp',
        Uint8List.fromList([]),
      );
      final file = fileSystem.file('app/assets/file.webp');
      addTearDown(() => file.deleteSync(recursive: true));

      await expectLater(future, completes);
      await future;
      expect(file.existsSync(), true);
    });
  });

  group('loadFile', () {
    test('returns correctly.', () {
      final file = fileSystem.file('app/assets/file.webp')
        ..createSync(recursive: true);
      addTearDown(() => file.deleteSync(recursive: true));

      expect(
        () => repository.loadFile('file.webp'),
        returnsNormally,
      );
    });
  });

  group('loadAssetsCount', () {
    test('returns 0 if asset directory does not exist.', () {
      expect(
        repository.loadAssetsCount(),
        0,
      );
    });

    test('returns correctly if asset directory exists.', () {
      final file = fileSystem.file('app/assets/file.webp')
        ..createSync(recursive: true);
      addTearDown(() => file.deleteSync(recursive: true));

      expect(
        repository.loadAssetsCount(),
        1,
      );
    });
  });
}

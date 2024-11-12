import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/utils/mixins/logger.dart';
import 'package:tft_guide/injector.dart';

@immutable
final class LocalFileStorageRepository
    with LoggerMixin
    implements FileStorageApi {
  const LocalFileStorageRepository();

  static final _appDir = Injector.instance.appDir;
  static final _fileSystem = Injector.instance.fileSystem;
  @visibleForTesting
  static final assetsDir = _fileSystem.directory(join(_appDir.path, 'assets'));
  static const _mimeType = 'webp';

  @override
  DateTime? loadLatestFileUpdatedAt() {
    const methodName = 'LocalFileStorageRepository.loadLatestFileUpdatedAt';

    if (!assetsDir.existsSync()) {
      logInfo(
        methodName,
        'Retrieved no latest file updated at.',
        stackTrace: StackTrace.current,
      );
      return null;
    }

    final files = assetsDir.listSync().whereType<File>();
    final fileStats = files.map((file) => file.statSync());
    final updatedAt = fileStats.map((file) => file.modified.toUtc()).maxOrNull;
    logInfo(
      methodName,
      'Retrieved latest file updated at: ${updatedAt?.toIso8601String()}.',
      stackTrace: StackTrace.current,
    );

    return updatedAt;
  }

  @override
  Future<void> save(String fileName, Uint8List bytes) async {
    final file = _fileSystem.file(
      join(assetsDir.path, fileName),
    )..createSync(recursive: true);
    await file.writeAsBytes(bytes);
    logInfo(
      'LocalFileStorageRepository.save',
      'Saved file.',
      parameters: {
        'fileName': fileName,
        'bytes': '${bytes.length} bytes',
      },
      stackTrace: StackTrace.current,
    );
  }

  @override
  File loadFile(String name) {
    final file = _fileSystem.file(
      join(assetsDir.path, '$name.$_mimeType'),
    );
    logInfo(
      'LocalFileStorageRepository.loadFile',
      'Loaded file: ${file.path}.',
      parameters: {'id': name},
      stackTrace: StackTrace.current,
    );

    return file;
  }

  @override
  int loadAssetsCount() {
    if (!assetsDir.existsSync()) {
      return 0;
    }

    final count = assetsDir.listSync().whereType<File>().length;
    logInfo(
      'LocalFileStorageRepository.loadAssetsCount',
      'Loaded assets count: $count.',
      stackTrace: StackTrace.current,
    );

    return count;
  }
}

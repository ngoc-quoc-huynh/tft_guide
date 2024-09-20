import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:path/path.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/domain/utils/mixins/logger.dart';
import 'package:tft_guide/injector.dart';

final class LocalFileStorageRepository
    with LoggerMixin
    implements FileStorageApi {
  const LocalFileStorageRepository();

  static final _appDir = Injector.instance.appDir;
  static final _assetsDir = Directory(join(_appDir.path, 'assets'));
  static const _mimeType = 'webp';

  @override
  DateTime? loadLatestFileUpdatedAt() {
    const methodName = 'LocalFileStorageRepository.loadLatestFileUpdatedAt';

    if (!_assetsDir.existsSync()) {
      logInfo(
        methodName,
        'Retrieved no latest file updated at.',
        stackTrace: StackTrace.current,
      );
      return null;
    }

    final files = _assetsDir.listSync().whereType<File>();
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
  Future<void> save(String id, Uint8List bytes) async {
    final file = await File(
      join(_assetsDir.path, id),
    ).create(recursive: true);
    await file.writeAsBytes(bytes);
    logInfo(
      'LocalFileStorageRepository.save',
      'Saved file.',
      parameters: {
        'id': id,
        'bytes': '${bytes.length} bytes',
      },
      stackTrace: StackTrace.current,
    );
  }

  @override
  File loadFile(String id) {
    final file = File(join(_assetsDir.path, '$id.$_mimeType'));
    logInfo(
      'LocalFileStorageRepository.loadFile',
      'Loaded file: ${file.path}.',
      parameters: {'id': id},
      stackTrace: StackTrace.current,
    );

    return file;
  }

  @override
  int loadAssetsCount() {
    if (!_assetsDir.existsSync()) {
      return 0;
    }

    final count = _assetsDir.listSync().whereType<File>().length;
    logInfo(
      'LocalFileStorageRepository.loadAssetsCount',
      'Loaded assets count: $count.',
      stackTrace: StackTrace.current,
    );
    return count;
  }
}

import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/injector.dart';

final class LocalFileStorageRepository implements FileStorageAPI {
  const LocalFileStorageRepository();

  static final _appDir = Injector.instance.appDir;
  static final _assetsDir = Directory(join(_appDir.path, 'assets'));
  static const _mimeType = 'webp';

  @override
  Future<void> save(String id, Uint8List bytes) async {
    final file = await File(
      join(_assetsDir.path, id),
    ).create(recursive: true);
    await file.writeAsBytes(bytes);
  }

  @override
  File loadFile(String id) => File(
        join(_assetsDir.path, '$id.$_mimeType'),
      );
}

import 'dart:io';
import 'dart:typed_data';

abstract interface class FileStorageApi {
  const FileStorageApi();

  DateTime? loadLatestFileUpdatedAt();

  Future<void> save(String fileName, Uint8List bytes);

  File loadFile(String name);

  int loadAssetsCount();

  Future<void> clear();
}

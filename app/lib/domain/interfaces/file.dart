import 'dart:io';
import 'dart:typed_data';

abstract interface class FileStorageApi {
  const FileStorageApi();

  DateTime? loadLatestFileUpdatedAt();

  Future<void> save(String id, Uint8List bytes);

  File loadFile(String id);
}

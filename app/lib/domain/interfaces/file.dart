import 'dart:io';
import 'dart:typed_data';

abstract interface class FileStorageAPI {
  const FileStorageAPI();

  Future<void> save(String id, Uint8List bytes);

  File loadFile(String id);
}

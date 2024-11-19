import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/image/file_storage.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

Future<void> main() async {
  final fileStorageApi = MockFileStorageApi();

  setUpAll(
    () => Injector.instance.registerSingleton<FileStorageApi>(fileStorageApi),
  );

  tearDownAll(Injector.instance.unregister<FileStorageApi>);

  when(() => fileStorageApi.loadFile('id')).thenReturn(TestFile.file);

  await goldenTest(
    'renders correctly.',
    fileName: 'file_storage_image',
    pumpBeforeTest: precacheImages,
    builder: () => const FileStorageImage(
      id: 'id',
      height: 100,
      width: 100,
    ),
  );
}

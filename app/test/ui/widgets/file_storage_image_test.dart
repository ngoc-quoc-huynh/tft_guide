import 'package:alchemist/alchemist.dart';
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/file_storage_image.dart';

import '../../mocks.dart';
import '../../utils.dart';

Future<void> main() async {
  final fileSystem = MemoryFileSystem();
  final fileStorageApi = MockFileStorageApi();

  setUpAll(
    () => Injector.instance.registerSingleton<FileStorageApi>(fileStorageApi),
  );

  tearDownAll(Injector.instance.unregister<FileStorageApi>);

  when(() => fileStorageApi.loadFile('id')).thenReturn(await TestImage().file);
  when(() => fileStorageApi.loadFile('error'))
      .thenReturn(fileSystem.file('error.png'));

  await goldenTest(
    'renders correctly.',
    fileName: 'file_storage_image',
    pumpBeforeTest: (tester) async {
      await precacheImages(tester);
      await tester.pumpAndSettle();
    },
    builder: () => GoldenTestScenario(
      name: 'Default',
      child: const FileStorageImage(
        id: 'id',
        height: 100,
        width: 100,
      ),
    ),
  );

  await goldenTest(
    'renders error correctly.',
    fileName: 'file_storage_image_error',
    builder: () => GoldenTestScenario(
      name: 'Error',
      child: const FileStorageImage(
        id: 'error',
        height: 100,
        width: 100,
      ),
    ),
  );
}

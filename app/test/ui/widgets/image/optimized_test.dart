import 'package:alchemist/alchemist.dart';
import 'package:file/memory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/assets.dart';
import 'package:tft_guide/ui/widgets/image/optimized.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

Future<void> main() async {
  final fileSystem = MemoryFileSystem();
  final fileStorageApi = MockFileStorageApi();

  setUpAll(
    () => Injector.instance.registerSingleton<FileStorageApi>(fileStorageApi),
  );

  tearDownAll(Injector.instance.unregister<FileStorageApi>);

  when(() => fileStorageApi.loadFile('id')).thenReturn(TestFile.file);
  when(() => fileStorageApi.loadFile('error'))
      .thenReturn(fileSystem.file('error.png'));

  await goldenTest(
    'renders asset correctly.',
    fileName: 'optimized_image_asset',
    pumpBeforeTest: precacheImages,
    builder: () => GoldenTestScenario(
      name: 'Default',
      child: OptimizedImage.asset(
        Assets.iron4,
        height: 100,
        width: 100,
      ),
    ),
  );
  await goldenTest(
    'renders file correctly.',
    fileName: 'optimized_image_file',
    pumpBeforeTest: precacheImages,
    builder: () => GoldenTestScenario(
      name: 'Default',
      child: OptimizedImage.file(
        TestFile.file,
        height: 100,
        width: 100,
      ),
    ),
  );

  await goldenTest(
    'renders error correctly.',
    fileName: 'optimized_image_error',
    builder: () => GoldenTestScenario(
      name: 'Error',
      child: OptimizedImage.file(
        fileSystem.file('error.png'),
        height: 100,
        width: 100,
      ),
    ),
  );
}

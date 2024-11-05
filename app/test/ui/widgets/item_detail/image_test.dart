import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/interfaces/file.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/item_detail/image.dart';

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
    fileName: 'image',
    pumpBeforeTest: precacheImages,
    builder: () => const ImageDetailImage(
      id: 'id',
    ),
  );
}

import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/license/page.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

Future<void> main() async {
  final packageInfo = MockPackageInfo();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(
        AppLocale.en.buildSync(),
      )
      ..registerSingleton<PackageInfo>(packageInfo),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<PackageInfo>(),
  );

  when(() => packageInfo.version).thenReturn('1.0.0');

  await goldenTest(
    'renders correctly.',
    fileName: 'page',
    pumpBeforeTest: precacheImages,
    constraints: pageConstraints(),
    builder: () => const CustomLicensePage(),
  );
}

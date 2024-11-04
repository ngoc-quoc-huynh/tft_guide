import 'package:alchemist/alchemist.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tft_guide/ui/widgets/custom_skeletonizer_config.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'custom_skeletonizer_config',
      pumpBeforeTest: (tester) => tester.pump(),
      builder: () => const CustomSkeletonizerConfig(
        child: Skeletonizer(
          child: Bone.square(
            size: 100,
          ),
        ),
      ),
    );

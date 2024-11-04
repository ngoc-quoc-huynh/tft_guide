import 'package:alchemist/alchemist.dart';
import 'package:tft_guide/ui/widgets/error_image.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'error_image',
      builder: () => GoldenTestScenario(
        name: 'Default',
        child: const ErrorImage(
          width: 50,
          height: 50,
        ),
      ),
    );

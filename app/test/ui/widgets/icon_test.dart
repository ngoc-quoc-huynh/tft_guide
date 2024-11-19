import 'package:alchemist/alchemist.dart';
import 'package:tft_guide/ui/widgets/icon.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'icon',
      builder: () => const CustomIcon.warning(),
    );

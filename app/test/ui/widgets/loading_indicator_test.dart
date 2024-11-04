import 'package:alchemist/alchemist.dart';
import 'package:tft_guide/ui/widgets/loading_indicator.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'loading_indicator',
      pumpBeforeTest: (tester) =>
          tester.pump(const Duration(milliseconds: 500)),
      builder: () => const LoadingIndicator(),
    );

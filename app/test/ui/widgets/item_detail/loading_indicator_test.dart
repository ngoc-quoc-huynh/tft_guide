import 'package:alchemist/alchemist.dart';
import 'package:tft_guide/ui/widgets/item_detail/loading_indicator.dart';

import '../../../utils.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'loading_indicator',
      pumpBeforeTest: (tester) =>
          tester.pump(const Duration(milliseconds: 500)),
      constraints: pageConstraints(),
      builder: () => const ItemDetailLoadingIndicator(),
    );

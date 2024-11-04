import 'package:alchemist/alchemist.dart';
import 'package:tft_guide/ui/pages/item_metas/loading_indicator.dart';

import '../../../utils.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'loading_indicator',
      constraints: pageConstraints(),
      pumpBeforeTest: (tester) async {
        await tester.pump();
      },
      builder: ItemLoadingIndicator.new,
    );

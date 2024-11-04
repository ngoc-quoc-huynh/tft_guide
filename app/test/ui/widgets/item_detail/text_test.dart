import 'package:alchemist/alchemist.dart';
import 'package:tft_guide/ui/widgets/item_detail/text.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'text',
      builder: () => const ItemDetailCardText(text: 'Text'),
    );

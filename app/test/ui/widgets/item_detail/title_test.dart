import 'package:alchemist/alchemist.dart';
import 'package:tft_guide/ui/widgets/item_detail/title.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'title',
      builder: () => const ItemDetailCardTitle(text: 'Title'),
    );

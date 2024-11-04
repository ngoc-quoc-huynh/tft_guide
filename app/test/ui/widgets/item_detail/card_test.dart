import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/ui/widgets/item_detail/card.dart';

Future<void> main() async {
  await goldenTest(
    'renders correctly.',
    fileName: 'card',
    builder: () => GoldenTestGroup(
      columns: 1,
      children: [
        GoldenTestScenario(
          name: 'BaseItemDetail',
          constraints: const BoxConstraints.tightFor(width: 350),
          child: const _TestWidget(),
        ),
        GoldenTestScenario(
          name: 'BaseItemDetail',
          constraints: const BoxConstraints.tightFor(width: 400),
          child: const _TestWidget(),
        ),
      ],
    ),
  );
}

final class _TestWidget extends StatelessWidget {
  const _TestWidget();

  @override
  Widget build(BuildContext context) {
    return const ItemDetailCard(
      title: Text('Title'),
      child: Text('Child'),
    );
  }
}

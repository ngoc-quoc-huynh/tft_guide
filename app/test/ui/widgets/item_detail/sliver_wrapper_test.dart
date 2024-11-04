import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:tft_guide/ui/widgets/item_detail/sliver_wrapper.dart';

Future<void> main() => goldenTest(
      'renders correctly.',
      fileName: 'sliver_wrapper',
      builder: () => ConstrainedBox(
        constraints: BoxConstraints.tight(const Size(150, 120)),
        child: CustomScrollView(
          slivers: [
            SliverWrapperItemDetail(
              child: Container(
                color: Colors.red,
                height: 100,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );

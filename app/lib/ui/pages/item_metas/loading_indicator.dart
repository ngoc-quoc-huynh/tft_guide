import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/item_metas/prototype_item.dart';

class ItemLoadingIndicator extends StatelessWidget {
  const ItemLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.horizontalPadding,
          vertical: Sizes.verticalPadding / 2,
        ),
        prototypeItem: const ItemMetasPrototypeItem(),
        children: List.filled(
          10,
          const _Item(),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item();

  @override
  Widget build(BuildContext context) {
    return const Card.filled(
      child: ListTile(
        contentPadding: Sizes.cardPadding,
        leading: Bone.square(size: 50),
        title: Bone.text(words: 2),
      ),
    );
  }
}

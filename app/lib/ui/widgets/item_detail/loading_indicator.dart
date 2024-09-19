import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/widgets/item_detail/card.dart';
import 'package:tft_guide/ui/widgets/item_detail/image.dart';
import 'package:tft_guide/ui/widgets/item_detail/stats/stats.dart';
import 'package:tft_guide/ui/widgets/item_detail/text.dart';
import 'package:tft_guide/ui/widgets/item_detail/title.dart';
import 'package:tft_guide/ui/widgets/scaffold.dart';

class ItemDetailLoadingIndicator extends StatelessWidget {
  const ItemDetailLoadingIndicator({
    this.additionalWidget,
    super.key,
  });

  final Widget? additionalWidget;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: CustomScaffold(
        appBar: AppBar(
          leading: const Skeleton.keep(
            child: BackButton(),
          ),
          title: const Bone.text(words: 2),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.horizontalPadding,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const ImageDetailImage.loading(),
              const SizedBox(height: 20),
              const ItemDetailCard(
                title: ItemDetailCardTitle.loading(),
                child: ItemDetailCardText.loading(),
              ),
              const SizedBox(height: 10),
              const ItemDetailCard(
                title: ItemDetailCardTitle.loading(),
                child: ItemDetailStats.loading(),
              ),
              const SizedBox(height: 10),
              const ItemDetailCard(
                title: ItemDetailCardTitle.loading(),
                child: ItemDetailCardText.loading(),
              ),
              if (additionalWidget case final Widget additionalWidget) ...[
                const SizedBox(height: 10),
                additionalWidget,
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

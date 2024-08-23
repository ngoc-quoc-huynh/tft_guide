import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/assets.dart';
import 'package:tft_guide/static/resources/sizes.dart';

class ImageDetailImage extends StatelessWidget {
  const ImageDetailImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.horizontalPadding),
      sliver: SliverToBoxAdapter(
        // TODO: Use real image
        child: Image.asset(
          Assets.bfSword.path,
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

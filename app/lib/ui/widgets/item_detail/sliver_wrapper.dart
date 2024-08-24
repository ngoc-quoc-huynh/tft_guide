import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/sizes.dart';

class SliverWrapperItemDetail extends StatelessWidget {
  const SliverWrapperItemDetail({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.horizontalPadding,
      ),
      sliver: SliverToBoxAdapter(
        child: child,
      ),
    );
  }
}

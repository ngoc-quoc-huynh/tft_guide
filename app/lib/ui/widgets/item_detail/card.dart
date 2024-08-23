import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/sizes.dart';

class ItemDetailCard extends StatelessWidget {
  const ItemDetailCard({
    required this.title,
    required this.child,
    super.key,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.horizontalPadding,
      ),
      sliver: SliverToBoxAdapter(
        child: Card.filled(
          // TODO: Extract card paddings
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

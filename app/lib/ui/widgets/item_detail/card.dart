import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/sizes.dart';

class ItemDetailCard extends StatelessWidget {
  const ItemDetailCard({
    required this.title,
    required this.child,
    super.key,
  });

  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Card.filled(
        child: Padding(
          padding: Sizes.cardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              child,
            ],
          ),
        ),
      ),
    );
  }
}

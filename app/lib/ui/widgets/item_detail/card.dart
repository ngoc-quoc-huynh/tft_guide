import 'package:flutter/material.dart';

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
        // TODO: Extract card paddings
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
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

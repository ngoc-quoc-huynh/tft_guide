import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/sizes.dart';

class ItemMetasPrototypeItem extends StatelessWidget {
  const ItemMetasPrototypeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: Sizes.maxWidgetWith,
        ),
        child: const Card.filled(
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            leading: SizedBox.square(
              dimension: 50,
            ),
          ),
        ),
      ),
    );
  }
}

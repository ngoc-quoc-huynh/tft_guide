import 'package:flutter/material.dart';

class ItemMetasPrototypeItem extends StatelessWidget {
  const ItemMetasPrototypeItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card.filled(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        leading: SizedBox.square(
          dimension: 50,
        ),
      ),
    );
  }
}

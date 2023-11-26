import 'package:flutter/material.dart';
import 'package:tft_guide/domain/models/item.dart';

class ItemsListElement extends StatelessWidget {
  const ItemsListElement({required this.item, super.key});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        item.asset.path,
        width: 50,
        height: 50,
      ),
      title: Text(item.name),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tft_guide/domain/models/item_preview.dart';
import 'package:tft_guide/ui/pages/items/item.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({required this.items, super.key});

  final List<ItemPreview> items;

  @override
  Widget build(BuildContext context) {
    // TODO: Use ListView.builder with prototypeItem for better performance.
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemBuilder: (context, index) => ItemsListElement(item: items[index]),
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemCount: items.length,
    );
  }
}

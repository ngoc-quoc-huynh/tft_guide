import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/models/old/item.dart';
import 'package:tft_guide/ui/pages/item/page.dart';

class ItemsListElement extends StatelessWidget {
  const ItemsListElement({required this.item, super.key});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.goNamed(
        ItemPage.routeName,
        pathParameters: {'id': item.id.toString()},
      ),
      leading: Image.asset(
        item.asset.path,
        width: 50,
        height: 50,
      ),
      title: Text(item.name),
    );
  }
}

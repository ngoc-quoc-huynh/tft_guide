import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/models/old/item.dart';
import 'package:tft_guide/ui/pages/item/page.dart';

class ItemComponent extends StatelessWidget {
  const ItemComponent({required this.item, super.key});

  final BaseItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => unawaited(
        context.pushNamed(
          ItemPage.routeName,
          pathParameters: {'id': item.id.toString()},
        ),
      ),
      child: Column(
        children: [
          Text(item.name),
          const SizedBox(height: 10),
          Image.asset(
            item.asset.path,
            height: 50,
            width: 50,
          ),
        ],
      ),
    );
  }
}

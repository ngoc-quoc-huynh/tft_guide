import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/static/resources/assets.dart';
import 'package:tft_guide/ui/pages/base_item_detail/page.dart';

class FullItemCombineBody extends StatelessWidget {
  const FullItemCombineBody({
    required this.itemId1,
    required this.itemId2,
    super.key,
  });

  final String itemId1;
  final String itemId2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _Image(itemId1),
          const Icon(Icons.add),
          _Image(itemId2),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image(this.id);

  final String id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: Ink.image(
        image: AssetImage(Assets.bfSword.path),
        height: 50,
        width: 50,
        fit: BoxFit.contain,
      ),
    );
  }

  void _onTap(BuildContext context) => unawaited(
        context.pushNamed(
          BaseItemDetailPage.routeName,
          pathParameters: {'id': id},
        ),
      );
}

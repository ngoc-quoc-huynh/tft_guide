import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/router/routes.dart';
import 'package:tft_guide/ui/widgets/image/file_storage.dart';

class FullItemDetailCombineBy extends StatelessWidget {
  const FullItemDetailCombineBy({
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
          _Image(
            id: itemId1,
            tooltip: _translations.item1,
          ),
          const Icon(Icons.add),
          _Image(
            id: itemId2,
            tooltip: _translations.item2,
          ),
        ],
      ),
    );
  }

  static TranslationsPagesItemDetailEn get _translations =>
      Injector.instance.translations.pages.itemDetail;
}

class _Image extends StatelessWidget {
  const _Image({
    required this.id,
    required this.tooltip,
  });

  final String id;
  final String tooltip;

  static const _imageSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => _onTap(context),
        child: FileStorageImage(
          id: id,
          height: _imageSize,
          width: _imageSize,
        ),
      ),
    );
  }

  void _onTap(BuildContext context) => unawaited(
        context.pushNamed(
          Routes.baseItemsPage(),
          pathParameters: {'id': id},
        ),
      );
}

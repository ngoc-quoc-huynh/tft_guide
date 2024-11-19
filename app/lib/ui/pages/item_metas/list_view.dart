import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/models/item_meta.dart';
import 'package:tft_guide/static/resources/sizes.dart';
import 'package:tft_guide/ui/pages/item_metas/prototype_item.dart';
import 'package:tft_guide/ui/router/routes.dart';
import 'package:tft_guide/ui/widgets/image/file_storage.dart';

class ItemMetasListView extends StatelessWidget {
  const ItemMetasListView({
    required this.items,
    super.key,
  });

  final List<ItemMeta> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.horizontalPadding,
        vertical: Sizes.verticalPadding / 2,
      ),
      itemBuilder: (context, index) => _Item(
        items[index],
      ),
      prototypeItem: const ItemMetasPrototypeItem(),
      itemCount: items.length,
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.item);

  final ItemMeta item;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: Sizes.maxWidgetWith,
        ),
        child: Card.filled(
          child: ListTile(
            onTap: () => _onTap(context),
            contentPadding: Sizes.cardPadding,
            leading: FileStorageImage(
              id: item.id,
              width: 50,
              height: 50,
              gaplessPlayback: true,
            ),
            title: Text(item.name),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) {
    final routeName = switch (item) {
      BaseItemMeta() => Routes.baseItemsPage,
      FullItemMeta() => Routes.fullItemsPage,
    };
    context.goNamed(
      routeName(),
      pathParameters: {'id': item.id},
    );
  }
}

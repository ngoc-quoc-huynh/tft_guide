import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/models/item_meta.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/base_item_detail/page.dart';
import 'package:tft_guide/ui/pages/full_item_detail/page.dart';
import 'package:tft_guide/ui/pages/item_metas/prototype_item.dart';

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
        horizontal: 20,
        vertical: 10,
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
    return Card.filled(
      child: ListTile(
        onTap: () => _onTap(context),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        leading: Image.file(
          Injector.instance.fileStorageAPI.loadFile(item.id),
          width: 50,
          height: 50,
          fit: BoxFit.contain,
          gaplessPlayback: true,
          // TODO: Add error widget
        ),
        title: Text(item.name),
      ),
    );
  }

  void _onTap(BuildContext context) {
    final routeName = switch (item) {
      BaseItemMeta() => BaseItemDetailPage.routeName,
      FullItemMeta() => FullItemDetailPage.routeName,
    };
    context.goNamed(
      routeName,
      pathParameters: {'id': item.id},
    );
  }
}

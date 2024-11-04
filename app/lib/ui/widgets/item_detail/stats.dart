import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/icons.dart';

class ItemDetailStats extends StatelessWidget {
  const ItemDetailStats({
    required this.item,
    super.key,
  });

  final ItemDetail item;

  @override
  Widget build(BuildContext context) {
    final gridItems = _generateGridItems();

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: _computeGridHeight(gridItems.length),
        child: MasonryGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          itemBuilder: (context, index) {
            final item = gridItems[index];
            return _GridViewItem(
              icon: item.icon,
              color: item.color,
              name: item.name,
              value: item.value,
            );
          },
          itemCount: gridItems.length,
        ),
      ),
    );
  }

  double _computeGridHeight(int statsLength) => (statsLength / 4).ceil() * 30;

  List<_GridItemData> _generateGridItems() {
    return [
      if (item.abilityPower case final int abilityPower)
        _GridItemData(
          icon: TftIcons.abilityPower,
          color: Colors.cyan,
          name: _translations.abilityPower,
          value: abilityPower,
        ),
      if (item.armor case final int armor)
        _GridItemData(
          icon: TftIcons.armor,
          color: Colors.deepOrange,
          name: _translations.armor,
          value: armor,
        ),
      if (item.attackDamage case final int attackDamage)
        _GridItemData(
          icon: TftIcons.attackDamage,
          color: Colors.orange,
          name: _translations.attackDamage,
          value: attackDamage,
        ),
      if (item.attackSpeed case final int attackSpeed)
        _GridItemData(
          icon: TftIcons.attackSpeed,
          color: Colors.amber,
          name: _translations.attackSpeed,
          value: attackSpeed,
        ),
      if (item.crit case final int crit)
        _GridItemData(
          icon: TftIcons.crit,
          color: Colors.red,
          name: _translations.crit,
          value: crit,
        ),
      if (item.health case final int health)
        _GridItemData(
          icon: TftIcons.health,
          color: Colors.green,
          name: _translations.health,
          value: health,
        ),
      if (item.magicResist case final int magicResist)
        _GridItemData(
          icon: TftIcons.magicResist,
          color: Colors.purple,
          name: _translations.magicResist,
          value: magicResist,
        ),
      if (item.mana case final int mana)
        _GridItemData(
          icon: TftIcons.mana,
          color: Colors.blue,
          name: _translations.mana,
          value: mana,
        ),
    ];
  }

  static TranslationsPagesItemDetailEn get _translations =>
      Injector.instance.translations.pages.itemDetail;
}

@immutable
final class _GridItemData {
  const _GridItemData({
    required this.icon,
    required this.color,
    required this.name,
    required this.value,
  });

  final IconData icon;
  final Color color;
  final String name;
  final int value;
}

class _GridViewItem extends StatelessWidget {
  const _GridViewItem({
    required this.icon,
    required this.color,
    required this.name,
    required this.value,
  });

  final IconData icon;
  final Color color;
  final String name;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: name,
      child: Row(
        children: [
          Icon(
            icon,
            color: color.harmonizeWith(Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(width: 5),
          Text(
            '+$value',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}

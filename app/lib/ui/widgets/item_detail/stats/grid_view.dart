part of 'stats.dart';

class _GridView extends ItemDetailStats {
  const _GridView({
    required this.item,
    super.key,
  });

  final ItemDetail item;

  @override
  Widget build(BuildContext context) {
    final gridItems = _generateGridItems();
    return Padding(
      padding: ItemDetailStats.padding,
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
          color: const Color(0xFF9BFFF7),
          name: _translations.abilityPower,
          value: abilityPower,
        ),
      if (item.armor case final int armor)
        _GridItemData(
          icon: TftIcons.armor,
          color: const Color(0xFFF16F59),
          name: _translations.armor,
          value: armor,
        ),
      if (item.attackDamage case final int attackDamage)
        _GridItemData(
          icon: TftIcons.attackDamage,
          color: const Color(0xFFBD7E4C),
          name: _translations.attackDamage,
          value: attackDamage,
        ),
      if (item.attackSpeed case final int attackSpeed)
        _GridItemData(
          icon: TftIcons.attackSpeed,
          color: const Color(0xFFF4C452),
          name: _translations.attackSpeed,
          value: attackSpeed,
        ),
      if (item.crit case final int crit)
        _GridItemData(
          icon: TftIcons.crit,
          color: const Color(0xFFCE3B44),
          name: _translations.crit,
          value: crit,
        ),
      if (item.health case final int health)
        _GridItemData(
          icon: TftIcons.health,
          color: const Color(0xFF20995D),
          name: _translations.health,
          value: health,
        ),
      if (item.magicResist case final int magicResist)
        _GridItemData(
          icon: TftIcons.magicResist,
          color: const Color(0xFFCF8DD1),
          name: _translations.magicResist,
          value: magicResist,
        ),
      if (item.mana case final int mana)
        _GridItemData(
          icon: TftIcons.mana,
          color: const Color(0xFF26C2F4),
          name: _translations.mana,
          value: mana,
        ),
    ];
  }

  TranslationsPagesItemDetailEn get _translations =>
      Injector.instance.translations.pages.item_detail;
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
            // TODO: harmonize color
            color: color,
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

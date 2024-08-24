part of 'stats.dart';

class _GridView extends ItemDetailStats {
  const _GridView({
    required this.item,
    super.key,
  });

  final ItemDetail item;

  @override
  Widget build(BuildContext context) {
    return _Body(item);
  }
}

class _Body extends StatefulWidget {
  const _Body(this.item);

  final ItemDetail item;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  late List<_GridViewItem> _stats;

  @override
  void initState() {
    super.initState();
    _stats = [
      if (widget.item.abilityPower case final int abilityPower)
        _GridViewItem(
          icon: TftIcons.abilityPower,
          color: const Color(0xFF9BFFF7),
          name: _translations.abilityPower,
          value: abilityPower,
        ),
      if (widget.item.armor case final int armor)
        _GridViewItem(
          icon: TftIcons.armor,
          color: const Color(0xFFF16F59),
          name: _translations.armor,
          value: armor,
        ),
      if (widget.item.attackDamage case final int attackDamage)
        _GridViewItem(
          icon: TftIcons.attackDamage,
          color: const Color(0xFFBD7E4C),
          name: _translations.attackDamage,
          value: attackDamage,
        ),
      if (widget.item.attackSpeed case final int attackSpeed)
        _GridViewItem(
          icon: TftIcons.attackSpeed,
          color: const Color(0xFFF4C452),
          name: _translations.attackSpeed,
          value: attackSpeed,
        ),
      if (widget.item.crit case final int crit)
        _GridViewItem(
          icon: TftIcons.crit,
          color: const Color(0xFFCE3B44),
          name: _translations.crit,
          value: crit,
        ),
      if (widget.item.health case final int health)
        _GridViewItem(
          icon: TftIcons.health,
          color: const Color(0xFF20995D),
          name: _translations.health,
          value: health,
        ),
      if (widget.item.magicResist case final int magicResist)
        _GridViewItem(
          icon: TftIcons.magicResist,
          color: const Color(0xFFCF8DD1),
          name: _translations.magicResist,
          value: magicResist,
        ),
      if (widget.item.mana case final int mana)
        _GridViewItem(
          icon: TftIcons.mana,
          color: const Color(0xFF26C2F4),
          name: _translations.mana,
          value: mana,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ItemDetailStats.padding,
      child: SizedBox(
        height: _computeGridHeight(_stats.length),
        child: MasonryGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          itemBuilder: (context, index) => _stats[index],
          itemCount: _stats.length,
        ),
      ),
    );
  }

  double _computeGridHeight(int statsLength) => (statsLength / 4).ceil() * 30;

  TranslationsPagesItemDetailDe get _translations =>
      Injector.instance.translations.pages.item_detail;
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

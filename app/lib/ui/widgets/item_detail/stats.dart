import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tft_guide/domain/models/item_detail.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/icons.dart';

class ItemDetailStats extends StatefulWidget {
  const ItemDetailStats({
    required this.item,
    super.key,
  });

  final ItemDetail item;

  @override
  State<ItemDetailStats> createState() => _ItemDetailStatsState();
}

class _ItemDetailStatsState extends State<ItemDetailStats> {
  late List<_Stat> _stats;

  @override
  void initState() {
    super.initState();
    _stats = [
      if (widget.item.abilityPower case final int abilityPower)
        _Stat(
          icon: TftIcons.abilityPower,
          color: const Color(0xFF9BFFF7),
          name: _messages.abilityPower,
          value: abilityPower,
        ),
      if (widget.item.armor case final int armor)
        _Stat(
          icon: TftIcons.armor,
          color: const Color(0xFFF16F59),
          name: _messages.armor,
          value: armor,
        ),
      if (widget.item.attackDamage case final int attackDamage)
        _Stat(
          icon: TftIcons.attackDamage,
          color: const Color(0xFFBD7E4C),
          name: _messages.attackDamage,
          value: attackDamage,
        ),
      if (widget.item.attackSpeed case final int attackSpeed)
        _Stat(
          icon: TftIcons.attackSpeed,
          color: const Color(0xFFF4C452),
          name: _messages.attackSpeed,
          value: attackSpeed,
        ),
      if (widget.item.crit case final int crit)
        _Stat(
          icon: TftIcons.crit,
          color: const Color(0xFFCE3B44),
          name: _messages.crit,
          value: crit,
        ),
      if (widget.item.health case final int health)
        _Stat(
          icon: TftIcons.health,
          color: const Color(0xFF20995D),
          name: _messages.health,
          value: health,
        ),
      if (widget.item.magicResist case final int magicResist)
        _Stat(
          icon: TftIcons.magicResist,
          color: const Color(0xFFCF8DD1),
          name: _messages.magicResist,
          value: magicResist,
        ),
      if (widget.item.mana case final int mana)
        _Stat(
          icon: TftIcons.mana,
          color: const Color(0xFF26C2F4),
          name: _messages.mana,
          value: mana,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
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

  TranslationsPagesItemDetailDe get _messages =>
      Injector.instance.translations.pages.item_detail;
}

class _Stat extends StatelessWidget {
  const _Stat({
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

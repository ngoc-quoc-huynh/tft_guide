import 'package:equatable/equatable.dart';
import 'package:tft_guide/static/resources/assets.dart';

sealed class Item extends Equatable {
  const Item({
    required this.name,
    required this.description,
    required this.asset,
    required this.abilityPower,
    required this.armor,
    required this.attackDamage,
    required this.attackSpeed,
    required this.crit,
    required this.health,
    required this.magicResist,
    required this.mana,
  });

  final String name;
  final String description;
  final Asset asset;
  final int abilityPower;
  final int armor;
  final int attackDamage;
  final int attackSpeed;
  final int crit;
  final int health;
  final int magicResist;
  final int mana;

  @override
  List<Object> get props => [
        name,
        description,
        asset,
        abilityPower,
        armor,
        attackDamage,
        attackSpeed,
        crit,
        health,
        magicResist,
        mana,
      ];
}

final class BaseItem extends Item {
  const BaseItem({
    required super.name,
    required super.description,
    required super.asset,
    required super.abilityPower,
    required super.armor,
    required super.attackDamage,
    required super.attackSpeed,
    required super.crit,
    required super.health,
    required super.magicResist,
    required super.mana,
  });
}

final class FullItem extends Item {
  const FullItem({
    required super.name,
    required super.description,
    required super.asset,
    required super.abilityPower,
    required super.armor,
    required super.attackDamage,
    required super.attackSpeed,
    required super.crit,
    required super.health,
    required super.magicResist,
    required super.mana,
    required this.baseItem1,
    required this.baseItem2,
  });

  final BaseItem baseItem1;
  final BaseItem baseItem2;

  @override
  List<Object> get props => [
        ...super.props,
        baseItem1,
        baseItem2,
      ];
}

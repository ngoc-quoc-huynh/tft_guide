import 'package:equatable/equatable.dart';
import 'package:tft_guide/static/resources/assets.dart';

sealed class Item extends Equatable {
  const Item({
    required this.name,
    required this.description,
    required this.asset,
    this.abilityPower,
    this.armor,
    this.attackDamage,
    this.attackSpeed,
    this.crit,
    this.health,
    this.magicResist,
    this.mana,
  });

  final String name;
  final String description;
  final Asset asset;
  final int? abilityPower;
  final int? armor;
  final int? attackDamage;
  final int? attackSpeed;
  final int? crit;
  final int? health;
  final int? magicResist;
  final int? mana;

  @override
  List<Object?> get props => [
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
    super.abilityPower,
    super.armor,
    super.attackDamage,
    super.attackSpeed,
    super.crit,
    super.health,
    super.magicResist,
    super.mana,
  });
}

final class FullItem extends Item {
  const FullItem({
    required super.name,
    required super.description,
    required super.asset,
    required this.baseItem1,
    required this.baseItem2,
    super.abilityPower,
    super.armor,
    super.attackDamage,
    super.attackSpeed,
    super.crit,
    super.health,
    super.magicResist,
    super.mana,
  });

  final BaseItem baseItem1;
  final BaseItem baseItem2;

  @override
  List<Object?> get props => [
        ...super.props,
        baseItem1,
        baseItem2,
      ];
}

import 'package:equatable/equatable.dart';

sealed class Item extends Equatable {
  const Item({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.abilityPower,
    this.armor,
    this.attackDamage,
    this.attackSpeed,
    this.crit,
    this.health,
    this.magicResist,
    this.mana,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
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
        id,
        createdAt,
        updatedAt,
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
    required super.id,
    required super.createdAt,
    required super.updatedAt,
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
    required super.id,
    required this.isActive,
    required this.itemId1,
    required this.itemId2,
    required super.createdAt,
    required super.updatedAt,
    super.abilityPower,
    super.armor,
    super.attackDamage,
    super.attackSpeed,
    super.crit,
    super.health,
    super.magicResist,
    super.mana,
  });

  final bool isActive;
  final String itemId1;
  final String itemId2;

  @override
  List<Object?> get props => [
        ...super.props,
        isActive,
        itemId1,
        itemId2,
      ];
}

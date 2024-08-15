import 'package:equatable/equatable.dart';

sealed class Item extends Equatable {
  const Item({
    required this.id,
    required this.name,
    required this.description,
    required this.isActive,
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
  final String name;
  final String description;
  final bool isActive;
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
        name,
        description,
        isActive,
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
    required super.name,
    required super.description,
    required super.isActive,
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
    required super.name,
    required super.description,
    required super.isActive,
    required this.baseItem1,
    required this.baseItem2,
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

  final BaseItem baseItem1;
  final BaseItem baseItem2;

  @override
  List<Object?> get props => [
        ...super.props,
        baseItem1,
        baseItem2,
      ];
}

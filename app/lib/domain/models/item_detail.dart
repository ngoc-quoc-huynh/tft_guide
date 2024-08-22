import 'package:equatable/equatable.dart';

sealed class ItemDetail extends Equatable {
  const ItemDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.hint,
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
  final String hint;
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
        hint,
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

final class BaseItemDetail extends ItemDetail {
  const BaseItemDetail({
    required super.id,
    required super.name,
    required super.description,
    required super.hint,
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

final class FullItemDetail extends ItemDetail {
  const FullItemDetail({
    required super.id,
    required super.name,
    required super.description,
    required super.hint,
    required this.itemId1,
    required this.itemId2,
    super.abilityPower,
    super.armor,
    super.attackDamage,
    super.attackSpeed,
    super.crit,
    super.health,
    super.magicResist,
    super.mana,
  });

  final String itemId1;
  final String itemId2;

  @override
  List<Object?> get props => [
        ...super.props,
        itemId1,
        itemId2,
      ];
}

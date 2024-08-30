import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/database/item.dart';

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

  ItemEntity toDomain();

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

  factory BaseItem.fromJson(Map<String, dynamic> json) => BaseItem(
        id: json['id'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        abilityPower: json['ability_power'] as int?,
        armor: json['armor'] as int?,
        attackDamage: json['attack_damage'] as int?,
        attackSpeed: json['attack_speed'] as int?,
        crit: json['crit'] as int?,
        health: json['health'] as int?,
        magicResist: json['magic_resist'] as int?,
        mana: json['mana'] as int?,
      );

  @override
  BaseItemEntity toDomain() => BaseItemEntity(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
        abilityPower: abilityPower,
        armor: armor,
        attackDamage: attackDamage,
        attackSpeed: attackSpeed,
        crit: crit,
        health: health,
        magicResist: magicResist,
        mana: mana,
      );
}

final class FullItem extends Item {
  const FullItem({
    required super.id,
    required this.isActive,
    required this.isSpecial,
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

  factory FullItem.fromJson(Map<String, dynamic> json) => FullItem(
        id: json['id'] as String,
        isActive: json['is_active'] as bool,
        isSpecial: json['is_special'] as bool,
        itemId1: json['item_id_1'] as String,
        itemId2: json['item_id_2'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        abilityPower: json['ability_power'] as int?,
        armor: json['armor'] as int?,
        attackDamage: json['attack_damage'] as int?,
        attackSpeed: json['attack_speed'] as int?,
        crit: json['crit'] as int?,
        health: json['health'] as int?,
        magicResist: json['magic_resist'] as int?,
        mana: json['mana'] as int?,
      );

  final bool isActive;
  final bool isSpecial;
  final String itemId1;
  final String itemId2;

  @override
  FullItemEntity toDomain() => FullItemEntity(
        id: id,
        isActive: isActive,
        isSpecial: isSpecial,
        itemId1: itemId1,
        itemId2: itemId2,
        createdAt: createdAt,
        updatedAt: updatedAt,
        abilityPower: abilityPower,
        armor: armor,
        attackDamage: attackDamage,
        attackSpeed: attackSpeed,
        crit: crit,
        health: health,
        magicResist: magicResist,
        mana: mana,
      );

  @override
  List<Object?> get props => [
        ...super.props,
        isActive,
        isSpecial,
        itemId1,
        itemId2,
      ];
}

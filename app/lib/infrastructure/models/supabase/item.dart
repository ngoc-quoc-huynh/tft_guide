import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/item.dart' as domain;

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

  domain.Item toDomain();

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

  factory BaseItem.fromJson(Map<String, dynamic> json) => BaseItem(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        isActive: json['is_active'] as bool,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        abilityPower: json['ability_power'] as int,
        armor: json['armor'] as int,
        attackDamage: json['attack_damage'] as int,
        attackSpeed: json['attack_speed'] as int,
        crit: json['crit'] as int,
        health: json['health'] as int,
        magicResist: json['magic_resist'] as int,
        mana: json['mana'] as int,
      );

  @override
  domain.BaseItem toDomain() => domain.BaseItem(
        id: id,
        name: name,
        description: description,
        isActive: isActive,
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

  factory FullItem.fromJson(Map<String, dynamic> json) => FullItem(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        isActive: json['is_active'] as bool,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
        abilityPower: json['ability_power'] as int,
        armor: json['armor'] as int,
        attackDamage: json['attack_damage'] as int,
        attackSpeed: json['attack_speed'] as int,
        crit: json['crit'] as int,
        health: json['health'] as int,
        magicResist: json['magic_resist'] as int,
        mana: json['mana'] as int,
        baseItem1: BaseItem.fromJson(
          json['base_item_1'] as Map<String, dynamic>,
        ),
        baseItem2: BaseItem.fromJson(
          json['base_item_2'] as Map<String, dynamic>,
        ),
      );

  final BaseItem baseItem1;
  final BaseItem baseItem2;

  @override
  domain.FullItem toDomain() => domain.FullItem(
        id: id,
        name: name,
        description: description,
        isActive: isActive,
        baseItem1: baseItem1.toDomain(),
        baseItem2: baseItem2.toDomain(),
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
        baseItem1,
        baseItem2,
      ];
}

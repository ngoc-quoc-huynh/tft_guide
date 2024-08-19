import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/item_detail.dart' as domain;

sealed class ItemDetail extends Equatable {
  const ItemDetail({
    required this.id,
    required this.name,
    required this.description,
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
  final int? abilityPower;
  final int? armor;
  final int? attackDamage;
  final int? attackSpeed;
  final int? crit;
  final int? health;
  final int? magicResist;
  final int? mana;

  domain.ItemDetail toDomain();

  @override
  List<Object?> get props => [
        id,
        name,
        description,
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
    super.abilityPower,
    super.armor,
    super.attackDamage,
    super.attackSpeed,
    super.crit,
    super.health,
    super.magicResist,
    super.mana,
  });

  factory BaseItemDetail.fromJson(Map<String, dynamic> json) => BaseItemDetail(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
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
  domain.BaseItemDetail toDomain() => domain.BaseItemDetail(
        id: id,
        name: name,
        description: description,
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

final class FullItemDetail extends ItemDetail {
  const FullItemDetail({
    required super.id,
    required super.name,
    required super.description,
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

  factory FullItemDetail.fromJson(Map<String, dynamic> json) => FullItemDetail(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        itemId1: json['item_id_1'] as String,
        itemId2: json['item_id_2'] as String,
        abilityPower: json['ability_power'] as int?,
        armor: json['armor'] as int?,
        attackDamage: json['attack_damage'] as int?,
        attackSpeed: json['attack_speed'] as int?,
        crit: json['crit'] as int?,
        health: json['health'] as int?,
        magicResist: json['magic_resist'] as int?,
        mana: json['mana'] as int?,
      );

  final String itemId1;
  final String itemId2;

  @override
  domain.FullItemDetail toDomain() => domain.FullItemDetail(
        id: id,
        name: name,
        description: description,
        itemId1: itemId1,
        itemId2: itemId2,
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
        itemId1,
        itemId2,
      ];
}

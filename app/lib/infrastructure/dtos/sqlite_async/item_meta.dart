import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/item_meta.dart' as domain;

sealed class ItemMeta extends Equatable {
  const ItemMeta({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  domain.ItemMeta toDomain();

  @override
  List<Object?> get props => [id, name];
}

final class BaseItemMeta extends ItemMeta {
  const BaseItemMeta({
    required super.id,
    required super.name,
  });

  factory BaseItemMeta.fromJson(Map<String, dynamic> json) => BaseItemMeta(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  @override
  domain.BaseItemMeta toDomain() => domain.BaseItemMeta(
        id: id,
        name: name,
      );
}

final class FullItemMeta extends ItemMeta {
  const FullItemMeta({
    required super.id,
    required super.name,
  });

  factory FullItemMeta.fromJson(Map<String, dynamic> json) => FullItemMeta(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  @override
  domain.FullItemMeta toDomain() => domain.FullItemMeta(
        id: id,
        name: name,
      );
}

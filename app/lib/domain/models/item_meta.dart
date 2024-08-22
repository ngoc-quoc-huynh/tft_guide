import 'package:equatable/equatable.dart';

sealed class ItemMeta extends Equatable {
  const ItemMeta({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

final class BaseItemMeta extends ItemMeta {
  const BaseItemMeta({
    required super.id,
    required super.name,
  });
}

final class FullItemMeta extends ItemMeta {
  const FullItemMeta({
    required super.id,
    required super.name,
  });
}

import 'package:equatable/equatable.dart';

enum Language { de, en }

sealed class ItemTranslation extends Equatable {
  const ItemTranslation({
    required this.id,
    required this.itemId,
    required this.language,
    required this.name,
    required this.description,
    required this.hint,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String itemId;
  final Language language;
  final String name;
  final String description;
  final String hint;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        itemId,
        language,
        name,
        description,
        hint,
        createdAt,
        updatedAt,
      ];
}

final class BaseItemTranslation extends ItemTranslation {
  const BaseItemTranslation({
    required super.id,
    required super.itemId,
    required super.language,
    required super.name,
    required super.description,
    required super.hint,
    required super.createdAt,
    required super.updatedAt,
  });
}

final class FullItemTranslation extends ItemTranslation {
  const FullItemTranslation({
    required super.id,
    required super.itemId,
    required super.language,
    required super.name,
    required super.description,
    required super.hint,
    required super.createdAt,
    required super.updatedAt,
  });
}

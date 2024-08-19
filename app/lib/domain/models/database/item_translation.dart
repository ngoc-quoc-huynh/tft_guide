import 'package:equatable/equatable.dart';

enum LanguageCode {
  de,
  en;
}

sealed class ItemTranslationEntity extends Equatable {
  const ItemTranslationEntity({
    required this.id,
    required this.itemId,
    required this.languageCode,
    required this.name,
    required this.description,
    required this.hint,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String itemId;
  final LanguageCode languageCode;
  final String name;
  final String description;
  final String hint;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        itemId,
        languageCode,
        name,
        description,
        hint,
        createdAt,
        updatedAt,
      ];
}

final class BaseItemTranslationEntity extends ItemTranslationEntity {
  const BaseItemTranslationEntity({
    required super.id,
    required super.itemId,
    required super.languageCode,
    required super.name,
    required super.description,
    required super.hint,
    required super.createdAt,
    required super.updatedAt,
  });
}

final class FullItemTranslationEntity extends ItemTranslationEntity {
  const FullItemTranslationEntity({
    required super.id,
    required super.itemId,
    required super.languageCode,
    required super.name,
    required super.description,
    required super.hint,
    required super.createdAt,
    required super.updatedAt,
  });
}

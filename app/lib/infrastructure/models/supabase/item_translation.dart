import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/item_translation.dart' as domain;

enum LanguageCode {
  de,
  en;

  domain.Language toDomain() => domain.Language.values.byName(name);
}

sealed class ItemTranslation extends Equatable {
  const ItemTranslation({
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

  domain.ItemTranslation toDomain();

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

final class BaseItemTranslation extends ItemTranslation {
  const BaseItemTranslation({
    required super.id,
    required super.itemId,
    required super.languageCode,
    required super.name,
    required super.description,
    required super.hint,
    required super.createdAt,
    required super.updatedAt,
  });

  factory BaseItemTranslation.fromJson(Map<String, dynamic> json) =>
      BaseItemTranslation(
        id: json['id'] as String,
        itemId: json['item_id'] as String,
        languageCode:
            LanguageCode.values.byName(json['language_code'] as String),
        name: json['name'] as String,
        description: json['description'] as String,
        hint: json['hint'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  @override
  domain.BaseItemTranslation toDomain() => domain.BaseItemTranslation(
        id: id,
        itemId: itemId,
        language: languageCode.toDomain(),
        name: name,
        description: description,
        hint: hint,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

final class FullItemTranslation extends ItemTranslation {
  const FullItemTranslation({
    required super.id,
    required super.itemId,
    required super.languageCode,
    required super.name,
    required super.description,
    required super.hint,
    required super.createdAt,
    required super.updatedAt,
  });

  factory FullItemTranslation.fromJson(Map<String, dynamic> json) =>
      FullItemTranslation(
        id: json['id'] as String,
        itemId: json['item_id'] as String,
        languageCode:
            LanguageCode.values.byName(json['language_code'] as String),
        name: json['name'] as String,
        description: json['description'] as String,
        hint: json['hint'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  @override
  domain.FullItemTranslation toDomain() => domain.FullItemTranslation(
        id: id,
        itemId: itemId,
        language: languageCode.toDomain(),
        name: name,
        description: description,
        hint: hint,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}
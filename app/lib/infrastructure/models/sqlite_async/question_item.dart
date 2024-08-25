import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/question_item.dart' as domain;

sealed class QuestionItem extends Equatable {
  const QuestionItem({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final String name;
  final String description;

  domain.QuestionItem toDomain();

  @override
  List<Object?> get props => [
        id,
        name,
        description,
      ];
}

final class QuestionBaseItem extends QuestionItem {
  const QuestionBaseItem({
    required super.id,
    required super.name,
    required super.description,
  });

  factory QuestionBaseItem.fromJson(Map<String, dynamic> json) =>
      QuestionBaseItem(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
      );

  @override
  domain.QuestionBaseItem toDomain() => domain.QuestionBaseItem(
        id: id,
        name: name,
        description: description,
      );
}

final class QuestionFullItem extends QuestionItem {
  const QuestionFullItem({
    required super.id,
    required super.name,
    required super.description,
    required this.itemId1,
    required this.itemId2,
  });

  factory QuestionFullItem.fromJson(Map<String, dynamic> json) =>
      QuestionFullItem(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        itemId1: json['item_id_1'] as String,
        itemId2: json['item_id_2'] as String,
      );

  final String itemId1;
  final String itemId2;

  @override
  domain.QuestionFullItem toDomain() => domain.QuestionFullItem(
        id: id,
        name: name,
        description: description,
        itemId1: itemId1,
        itemId2: itemId2,
      );

  @override
  List<Object?> get props => [
        ...super.props,
        itemId1,
        itemId2,
      ];
}

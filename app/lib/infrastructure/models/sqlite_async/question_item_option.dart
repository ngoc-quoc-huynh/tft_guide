import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/question/item_option.dart' as domain;
import 'package:tft_guide/domain/utils/extensions/bool.dart';

sealed class QuestionItemOption extends Equatable {
  const QuestionItemOption({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final String name;
  final String description;

  domain.QuestionItemOption toDomain();

  @override
  List<Object?> get props => [
        id,
        name,
        description,
      ];
}

final class QuestionBaseItemOption extends QuestionItemOption {
  const QuestionBaseItemOption({
    required super.id,
    required super.name,
    required super.description,
  });

  factory QuestionBaseItemOption.fromJson(Map<String, dynamic> json) =>
      QuestionBaseItemOption(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
      );

  @override
  domain.QuestionBaseItemOption toDomain() => domain.QuestionBaseItemOption(
        id: id,
        name: name,
        description: description,
      );
}

final class QuestionFullItemOption extends QuestionItemOption {
  const QuestionFullItemOption({
    required super.id,
    required super.name,
    required super.description,
    required this.isSpecial,
    required this.itemId1,
    required this.itemId2,
  });

  factory QuestionFullItemOption.fromJson(Map<String, dynamic> json) =>
      QuestionFullItemOption(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        isSpecial: BoolExtension.parseInt(json['is_special'] as int),
        itemId1: json['item_id_1'] as String,
        itemId2: json['item_id_2'] as String,
      );

  final bool isSpecial;
  final String itemId1;
  final String itemId2;

  @override
  domain.QuestionFullItemOption toDomain() => domain.QuestionFullItemOption(
        id: id,
        name: name,
        description: description,
        isSpecial: isSpecial,
        itemId1: itemId1,
        itemId2: itemId2,
      );

  @override
  List<Object?> get props => [
        ...super.props,
        isSpecial,
        itemId1,
        itemId2,
      ];
}

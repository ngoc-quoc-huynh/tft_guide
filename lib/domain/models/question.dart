import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tft_guide/domain/models/item.dart';

enum QuestionType {
  image,
  text;

  factory QuestionType.random() => QuestionType.values.sample(1).first;
}

@immutable
sealed class Question extends Equatable {
  const Question({
    required this.type,
    required this.correctOption,
    required this.option1,
    required this.option2,
  });

  final QuestionType type;
  final Item correctOption;
  final Item option1;
  final Item option2;

  @override
  List<Object?> get props => [type, correctOption, option1, option2];
}

final class TitleQuestion extends Question {
  const TitleQuestion({
    required super.type,
    required super.correctOption,
    required super.option1,
    required super.option2,
  }) : assert(
          (correctOption is BaseItem &&
                  option1 is BaseItem &&
                  option2 is BaseItem) ||
              (correctOption is FullItem &&
                  option1 is FullItem &&
                  option2 is FullItem),
          'All items must be of the same type.',
        );

  const TitleQuestion.fromBaseItem({
    required super.type,
    required BaseItem correctOption,
    required BaseItem option1,
    required BaseItem option2,
  }) : super(
          correctOption: correctOption,
          option1: option1,
          option2: option2,
        );

  const TitleQuestion.fromFullItem({
    required super.type,
    required FullItem correctOption,
    required FullItem option1,
    required FullItem option2,
  }) : super(
          correctOption: correctOption,
          option1: option1,
          option2: option2,
        );
}

final class DescriptionQuestion extends Question {
  const DescriptionQuestion({
    required super.type,
    required super.correctOption,
    required super.option1,
    required super.option2,
  }) : assert(
          (correctOption is BaseItem &&
                  option1 is BaseItem &&
                  option2 is BaseItem) ||
              (correctOption is FullItem &&
                  option1 is FullItem &&
                  option2 is FullItem),
          'All items must be of the same type.',
        );

  const DescriptionQuestion.fromBaseItem({
    required super.type,
    required BaseItem correctOption,
    required BaseItem option1,
    required BaseItem option2,
  }) : super(
          correctOption: correctOption,
          option1: option1,
          option2: option2,
        );

  const DescriptionQuestion.fromFullItem({
    required super.type,
    required FullItem correctOption,
    required FullItem option1,
    required FullItem option2,
  }) : super(
          correctOption: correctOption,
          option1: option1,
          option2: option2,
        );
}

final class BaseComponentsQuestion extends Question {
  const BaseComponentsQuestion.build({
    required super.type,
    required FullItem correctOption,
    required FullItem option1,
    required FullItem option2,
  }) : super(
          correctOption: correctOption,
          option1: option1,
          option2: option2,
        );
}

final class FullItemQuestion extends Question {
  const FullItemQuestion.build({
    required super.type,
    required FullItem correctOption,
    required FullItem option1,
    required FullItem option2,
  }) : super(
          correctOption: correctOption,
          option1: option1,
          option2: option2,
        );
}

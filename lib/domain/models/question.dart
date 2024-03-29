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
    required this.options,
  });

  final QuestionType type;
  final Item correctOption;
  final List<Item> options;

  @override
  List<Object?> get props => [type, correctOption, options];
}

final class TitleQuestion extends Question {
  const TitleQuestion({
    required super.type,
    required super.correctOption,
    required super.options,
  }) : assert(
          (correctOption is BaseItem && options is List<BaseItem>) ||
              (correctOption is FullItem && options is List<FullItem>),
          'All options must be of the same type.',
        );

  const TitleQuestion.fromBaseItem({
    required super.type,
    required BaseItem correctOption,
    required List<BaseItem> options,
  }) : super(
          correctOption: correctOption,
          options: options,
        );

  const TitleQuestion.fromFullItem({
    required super.type,
    required FullItem correctOption,
    required List<FullItem> options,
  }) : super(
          correctOption: correctOption,
          options: options,
        );
}

final class DescriptionQuestion extends Question {
  const DescriptionQuestion({
    required super.type,
    required super.correctOption,
    required super.options,
  }) : assert(
          (correctOption is BaseItem && options is List<BaseItem>) ||
              (correctOption is FullItem && options is List<FullItem>),
          'All options must be of the same type.',
        );

  const DescriptionQuestion.fromBaseItem({
    required super.type,
    required BaseItem correctOption,
    required List<BaseItem> options,
  }) : super(
          correctOption: correctOption,
          options: options,
        );

  const DescriptionQuestion.fromFullItem({
    required super.type,
    required FullItem correctOption,
    required List<FullItem> options,
  }) : super(
          correctOption: correctOption,
          options: options,
        );
}

final class BaseComponentsQuestion extends Question {
  const BaseComponentsQuestion.build({
    required super.type,
    required FullItem correctOption,
    required List<FullItem> options,
  }) : super(
          correctOption: correctOption,
          options: options,
        );
}

final class FullItemQuestion extends Question {
  const FullItemQuestion.build({
    required super.type,
    required FullItem correctOption,
    required List<FullItem> options,
  }) : super(
          correctOption: correctOption,
          options: options,
        );
}

import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/question/item_option.dart';

sealed class Question extends Equatable {
  const Question({
    required this.correctOption,
    required this.otherOptions,
  });

  final QuestionItemOption correctOption;
  final List<QuestionItemOption> otherOptions;

  @override
  List<Object?> get props => [
        correctOption,
        otherOptions,
      ];
}

final class BaseItemsTextQuestion extends Question {
  const BaseItemsTextQuestion({
    required QuestionFullItemOption correctOption,
    required List<QuestionFullItemOption> otherOptions,
  }) : super(
          correctOption: correctOption,
          otherOptions: otherOptions,
        );
}

final class BaseItemsImageQuestion extends Question {
  const BaseItemsImageQuestion({
    required QuestionFullItemOption correctOption,
    required List<QuestionFullItemOption> otherOptions,
  }) : super(
          correctOption: correctOption,
          otherOptions: otherOptions,
        );
}

final class FullItemTextQuestion extends Question {
  const FullItemTextQuestion({
    required QuestionFullItemOption correctOption,
    required List<QuestionFullItemOption> otherOptions,
  }) : super(
          correctOption: correctOption,
          otherOptions: otherOptions,
        );
}

final class FullItemImageQuestion extends Question {
  const FullItemImageQuestion({
    required QuestionFullItemOption correctOption,
    required List<QuestionFullItemOption> otherOptions,
  }) : super(
          correctOption: correctOption,
          otherOptions: otherOptions,
        );
}

final class TitleTextQuestion extends Question {
  const TitleTextQuestion({
    required super.correctOption,
    required super.otherOptions,
  }) : assert(
          (correctOption is QuestionBaseItemOption &&
                  otherOptions is List<QuestionBaseItemOption>) ||
              (correctOption is QuestionFullItemOption &&
                  otherOptions is List<QuestionFullItemOption>),
          'All item options must be of the same type.',
        );
}

final class TitleImageQuestion extends Question {
  const TitleImageQuestion({
    required super.correctOption,
    required super.otherOptions,
  }) : assert(
          (correctOption is QuestionBaseItemOption &&
                  otherOptions is List<QuestionBaseItemOption>) ||
              (correctOption is QuestionFullItemOption &&
                  otherOptions is List<QuestionFullItemOption>),
          'All item options must be of the same type.',
        );
}

final class DescriptionTextQuestion extends Question {
  const DescriptionTextQuestion({
    required super.correctOption,
    required super.otherOptions,
  }) : assert(
          (correctOption is QuestionBaseItemOption &&
                  otherOptions is List<QuestionBaseItemOption>) ||
              (correctOption is QuestionFullItemOption &&
                  otherOptions is List<QuestionFullItemOption>),
          'All item options must be of the same type.',
        );
}

final class DescriptionImageQuestion extends Question {
  const DescriptionImageQuestion({
    required super.correctOption,
    required super.otherOptions,
  }) : assert(
          (correctOption is QuestionBaseItemOption &&
                  otherOptions is List<QuestionBaseItemOption>) ||
              (correctOption is QuestionFullItemOption &&
                  otherOptions is List<QuestionFullItemOption>),
          'All item options must be of the same type.',
        );
}

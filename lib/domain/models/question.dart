import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/question_item.dart';

sealed class Question extends Equatable {
  const Question({
    required this.correctItem,
    required this.otherItems,
  });

  final QuestionItem correctItem;
  final List<QuestionItem> otherItems;

  @override
  List<Object?> get props => [
        correctItem,
        otherItems,
      ];
}

final class BaseItemsTextQuestion extends Question {
  const BaseItemsTextQuestion({
    required QuestionFullItem correctItem,
    required List<QuestionFullItem> otherItems,
  }) : super(
          correctItem: correctItem,
          otherItems: otherItems,
        );
}

final class BaseItemsImageQuestion extends Question {
  const BaseItemsImageQuestion({
    required QuestionFullItem correctItem,
    required List<QuestionFullItem> otherItems,
  }) : super(
          correctItem: correctItem,
          otherItems: otherItems,
        );
}

final class FullItemTextQuestion extends Question {
  const FullItemTextQuestion({
    required QuestionFullItem correctItem,
    required List<QuestionFullItem> otherItems,
  }) : super(
          correctItem: correctItem,
          otherItems: otherItems,
        );
}

final class FullItemImageQuestion extends Question {
  const FullItemImageQuestion({
    required QuestionFullItem correctItem,
    required List<QuestionFullItem> otherItems,
  }) : super(
          correctItem: correctItem,
          otherItems: otherItems,
        );
}

final class TitleTextQuestion extends Question {
  const TitleTextQuestion({
    required super.correctItem,
    required super.otherItems,
  }) : assert(
          (correctItem is QuestionBaseItem &&
                  otherItems is List<QuestionBaseItem>) ||
              (correctItem is QuestionFullItem &&
                  otherItems is List<QuestionFullItem>),
          'All items must be of the same type.',
        );
}

final class TitleImageQuestion extends Question {
  const TitleImageQuestion({
    required super.correctItem,
    required super.otherItems,
  }) : assert(
          (correctItem is QuestionBaseItem &&
                  otherItems is List<QuestionBaseItem>) ||
              (correctItem is QuestionFullItem &&
                  otherItems is List<QuestionFullItem>),
          'All items must be of the same type.',
        );
}

final class DescriptionTextQuestion extends Question {
  const DescriptionTextQuestion({
    required super.correctItem,
    required super.otherItems,
  }) : assert(
          (correctItem is QuestionBaseItem &&
                  otherItems is List<QuestionBaseItem>) ||
              (correctItem is QuestionFullItem &&
                  otherItems is List<QuestionFullItem>),
          'All items must be of the same type.',
        );
}

final class DescriptionImageQuestion extends Question {
  const DescriptionImageQuestion({
    required super.correctItem,
    required super.otherItems,
  }) : assert(
          (correctItem is QuestionBaseItem &&
                  otherItems is List<QuestionBaseItem>) ||
              (correctItem is QuestionFullItem &&
                  otherItems is List<QuestionFullItem>),
          'All items must be of the same type.',
        );
}

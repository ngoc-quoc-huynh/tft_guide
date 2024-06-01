import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/item.dart';

sealed class Question extends Equatable {
  const Question({
    required this.correctItem,
    required this.otherItems,
  });

  final Item correctItem;
  final List<Item> otherItems;

  @override
  List<Object?> get props => [
        correctItem,
        otherItems,
      ];
}

final class BaseItemsTextQuestion extends Question {
  const BaseItemsTextQuestion({
    required FullItem correctItem,
    required List<FullItem> otherItems,
  }) : super(
          correctItem: correctItem,
          otherItems: otherItems,
        );
}

final class BaseItemsImageQuestion extends Question {
  const BaseItemsImageQuestion({
    required FullItem correctItem,
    required List<FullItem> otherItems,
  }) : super(
          correctItem: correctItem,
          otherItems: otherItems,
        );
}

final class FullItemTextQuestion extends Question {
  const FullItemTextQuestion({
    required FullItem correctItem,
    required List<FullItem> otherItems,
  }) : super(
          correctItem: correctItem,
          otherItems: otherItems,
        );
}

final class FullItemImageQuestion extends Question {
  const FullItemImageQuestion({
    required FullItem correctItem,
    required List<FullItem> otherItems,
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
          (correctItem is BaseItem && otherItems is List<BaseItem>) ||
              (correctItem is FullItem && otherItems is List<FullItem>),
          'All items must be of the same type.',
        );
}

final class TitleImageQuestion extends Question {
  const TitleImageQuestion({
    required super.correctItem,
    required super.otherItems,
  }) : assert(
          (correctItem is BaseItem && otherItems is List<BaseItem>) ||
              (correctItem is FullItem && otherItems is List<FullItem>),
          'All items must be of the same type.',
        );
}

final class DescriptionTextQuestion extends Question {
  const DescriptionTextQuestion({
    required super.correctItem,
    required super.otherItems,
  }) : assert(
          (correctItem is BaseItem && otherItems is List<BaseItem>) ||
              (correctItem is FullItem && otherItems is List<FullItem>),
          'All items must be of the same type.',
        );
}

final class DescriptionImageQuestion extends Question {
  const DescriptionImageQuestion({
    required super.correctItem,
    required super.otherItems,
  }) : assert(
          (correctItem is BaseItem && otherItems is List<BaseItem>) ||
              (correctItem is FullItem && otherItems is List<FullItem>),
          'All items must be of the same type.',
        );
}

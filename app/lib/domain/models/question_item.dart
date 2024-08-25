import 'package:equatable/equatable.dart';

sealed class QuestionItem extends Equatable {
  const QuestionItem({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final String name;
  final String description;

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
}

final class QuestionFullItem extends QuestionItem {
  const QuestionFullItem({
    required super.id,
    required super.name,
    required super.description,
    required this.itemId1,
    required this.itemId2,
  });

  final String itemId1;
  final String itemId2;

  @override
  List<Object?> get props => [
        ...super.props,
        itemId1,
        itemId2,
      ];
}

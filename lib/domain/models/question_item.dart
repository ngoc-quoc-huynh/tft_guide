import 'package:equatable/equatable.dart';
import 'package:tft_guide/static/resources/assets.dart';

sealed class QuestionItem extends Equatable {
  const QuestionItem({
    required this.name,
    required this.description,
    required this.asset,
  });

  final String name;
  final String description;
  final Asset asset;

  @override
  List<Object?> get props => [
        name,
        description,
        asset,
      ];
}

final class QuestionBaseItem extends QuestionItem {
  const QuestionBaseItem({
    required super.name,
    required super.description,
    required super.asset,
  });
}

final class QuestionFullItem extends QuestionItem {
  const QuestionFullItem({
    required super.name,
    required super.description,
    required super.asset,
    required this.baseItem1,
    required this.baseItem2,
  });

  final QuestionBaseItem baseItem1;
  final QuestionBaseItem baseItem2;

  @override
  List<Object?> get props => [
        ...super.props,
        baseItem1,
        baseItem2,
      ];
}

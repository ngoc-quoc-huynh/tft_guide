import 'package:equatable/equatable.dart';

sealed class QuestionItemOption extends Equatable {
  const QuestionItemOption({
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

final class QuestionBaseItemOption extends QuestionItemOption {
  const QuestionBaseItemOption({
    required super.id,
    required super.name,
    required super.description,
  });
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

  final bool isSpecial;
  final String itemId1;
  final String itemId2;

  @override
  List<Object?> get props => [
        ...super.props,
        isSpecial,
        itemId1,
        itemId2,
      ];
}

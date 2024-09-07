import 'package:equatable/equatable.dart';

final class PatchNote extends Equatable {
  const PatchNote({
    required this.text,
    required this.createdAt,
  });

  final String text;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        text,
        createdAt,
      ];
}

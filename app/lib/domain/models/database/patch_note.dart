import 'package:equatable/equatable.dart';

final class PatchNoteEntity extends Equatable {
  const PatchNoteEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/database/patch_note.dart';

final class PatchNote extends Equatable {
  const PatchNote({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PatchNote.fromJson(Map<String, dynamic> json) => PatchNote(
        id: json['id'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  PatchNoteEntity toDomain() => PatchNoteEntity(
        id: id,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
      ];
}

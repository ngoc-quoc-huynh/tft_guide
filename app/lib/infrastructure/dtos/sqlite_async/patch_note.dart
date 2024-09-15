import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/patch_note.dart' as domain;

final class PaginatedPatchNotes extends Equatable {
  const PaginatedPatchNotes({
    required this.patchNotes,
    required this.totalPages,
  });

  factory PaginatedPatchNotes.fromJson({
    required int pageSize,
    required int count,
    required List<Map<String, dynamic>> patchNotesJson,
  }) =>
      PaginatedPatchNotes(
        totalPages: (count / pageSize).ceil(),
        patchNotes: patchNotesJson.map(PatchNote.fromJson).toList(),
      );

  final List<PatchNote> patchNotes;
  final int totalPages;

  domain.PaginatedPatchNotes toDomain() => domain.PaginatedPatchNotes(
        totalPages: totalPages,
        patchNotes: patchNotes
            .map(
              (patchNote) => patchNote.toDomain(),
            )
            .toList(),
      );

  @override
  List<Object?> get props => [
        patchNotes,
        totalPages,
      ];
}

final class PatchNote extends Equatable {
  const PatchNote({
    required this.text,
    required this.createdAt,
  });

  factory PatchNote.fromJson(Map<String, dynamic> json) => PatchNote(
        text: json['text'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
      );

  final String text;
  final DateTime createdAt;

  domain.PatchNote toDomain() => domain.PatchNote(
        text: text,
        createdAt: createdAt,
      );

  @override
  List<Object?> get props => [
        text,
        createdAt,
      ];
}

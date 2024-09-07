import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/patch_note.dart' as domain;

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
        text: text.replaceAll(r'\n', '\n'),
        createdAt: createdAt,
      );

  @override
  List<Object?> get props => [
        text,
        createdAt,
      ];
}

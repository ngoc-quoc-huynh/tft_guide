import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/database/patch_note_translation.dart'
    as domain;

final class PatchNoteTranslation extends Equatable {
  const PatchNoteTranslation({
    required this.id,
    required this.patchNoteId,
    required this.languageCode,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PatchNoteTranslation.fromJson(Map<String, dynamic> json) =>
      PatchNoteTranslation(
        id: json['id'] as String,
        patchNoteId: json['patch_note_id'] as String,
        languageCode:
            LanguageCode.values.byName(json['language_code'] as String),
        text: json['text'] as String,
        createdAt: DateTime.parse(json['created_at'] as String),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  final String id;
  final String patchNoteId;
  final LanguageCode languageCode;
  final String text;
  final DateTime createdAt;
  final DateTime updatedAt;

  domain.PatchNoteTranslationEntity toDomain() =>
      domain.PatchNoteTranslationEntity(
        id: id,
        patchNoteId: patchNoteId,
        languageCode: languageCode,
        text: text,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        patchNoteId,
        languageCode,
        text,
        createdAt,
        updatedAt,
      ];
}

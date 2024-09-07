import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';

final class PatchNoteTranslationTranslationEntity extends Equatable {
  const PatchNoteTranslationTranslationEntity({
    required this.id,
    required this.patchNoteId,
    required this.languageCode,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String patchNoteId;
  final LanguageCode languageCode;
  final String text;
  final DateTime createdAt;
  final DateTime updatedAt;

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

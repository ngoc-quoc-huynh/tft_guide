import 'package:equatable/equatable.dart';

final class PaginatedPatchNotes extends Equatable {
  const PaginatedPatchNotes({
    required this.patchNotes,
    required this.totalPages,
  });

  final List<PatchNote> patchNotes;
  final int totalPages;

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

  final String text;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        text,
        createdAt,
      ];
}

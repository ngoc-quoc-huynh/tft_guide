part of '../bloc.dart';

final class CheckDatabaseLoadOnValid extends CheckDataLoadOnValid {
  const CheckDatabaseLoadOnValid({
    required this.localDataCount,
    required this.remoteDataCount,
    required this.localTranslationCount,
    required this.remoteTranslationCount,
  });

  final int localDataCount;
  final int remoteDataCount;
  final int localTranslationCount;
  final int remoteTranslationCount;

  @override
  List<Object?> get props => [
        localDataCount,
        remoteDataCount,
        localTranslationCount,
        remoteTranslationCount,
      ];
}

final class CheckDatabaseLoadOnInvalid extends CheckDataLoadOnInvalid {
  const CheckDatabaseLoadOnInvalid({
    required this.localDataCount,
    required this.remoteDataCount,
    required this.localTranslationCount,
    required this.remoteTranslationCount,
  });

  final int localDataCount;
  final int remoteDataCount;
  final int localTranslationCount;
  final int remoteTranslationCount;

  @override
  List<Object?> get props => [
        localDataCount,
        remoteDataCount,
        localTranslationCount,
        remoteTranslationCount,
      ];
}

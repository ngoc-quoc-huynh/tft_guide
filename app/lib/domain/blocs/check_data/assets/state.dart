part of '../bloc.dart';

final class CheckAssetsLoadOnValid extends CheckDataLoadOnValid {
  const CheckAssetsLoadOnValid({
    required this.localCount,
    required this.remoteCount,
  });

  final int localCount;
  final int remoteCount;

  @override
  List<Object?> get props => [
        localCount,
        remoteCount,
      ];
}

final class CheckAssetsLoadOnInvalid extends CheckDataLoadOnInvalid {
  const CheckAssetsLoadOnInvalid({
    required this.localCount,
    required this.remoteCount,
  });

  final int localCount;
  final int remoteCount;

  @override
  List<Object?> get props => [
        localCount,
        remoteCount,
      ];
}

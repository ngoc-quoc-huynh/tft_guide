import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Rank extends Equatable {
  const Rank({
    required this.name,
    required this.asset,
  });

  final String name;
  final String asset;

  @override
  List<Object?> get props => [name, asset];
}

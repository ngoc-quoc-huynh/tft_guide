import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tft_guide/static/resources/assets.dart';

@immutable
final class Rank extends Equatable {
  const Rank({
    required this.name,
    required this.number,
    required this.asset,
  });

  final String name;
  final int? number;
  final Asset asset;

  @override
  List<Object?> get props => [name, number, asset];
}

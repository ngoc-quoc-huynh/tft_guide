import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class RankOld extends Equatable {
  const RankOld({
    required this.tier,
    required this.division,
    required this.lp,
  });

  final Tier2 tier;
  final Division2 division;
  final int lp;

  @override
  List<Object?> get props => [tier, division, lp];
}

enum Tier2 {
  iron,
  bronze,
  silver,
  gold,
  platinum,
  emerald,
  diamond,
  master,
  grandmaster,
  challenger,
}

enum Division2 {
  one,
  two,
  three,
  four,
}

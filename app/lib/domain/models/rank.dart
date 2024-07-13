import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class Rank extends Equatable {
  const Rank({
    required this.tier,
    required this.division,
    required this.lp,
  });

  final Tier tier;
  final Division division;
  final int lp;

  @override
  List<Object?> get props => [tier, division, lp];
}

enum Tier {
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

enum Division {
  one,
  two,
  three,
  four,
}

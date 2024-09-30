import 'package:equatable/equatable.dart';
import 'package:tft_guide/domain/models/asset.dart';
import 'package:tft_guide/domain/models/rank/division.dart';
import 'package:tft_guide/domain/models/rank/tier.dart';

final class Rank extends Equatable {
  const Rank({
    required this.tier,
    required this.division,
    required this.asset,
  });

  final Tier tier;
  final Division division;
  // ignore: avoid-dynamic, false-positive. Remove when https://github.com/bancolombia/dart-code-linter/issues/142 is resolved.
  final Asset asset;

  @override
  List<Object?> get props => [
        tier,
        division,
        asset,
      ];
}

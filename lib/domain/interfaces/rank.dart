import 'package:tft_guide/domain/models/rank.dart';

abstract interface class RankRepository {
  const RankRepository();

  Rank computeRank(int elo);
}

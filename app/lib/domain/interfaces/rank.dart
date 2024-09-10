import 'package:tft_guide/domain/models/rank/rank.dart';

abstract interface class RankApi {
  const RankApi();

  int computeLp(int elo);

  Rank computeRank(int elo);
}

import 'package:tft_guide/domain/models/rank.dart';
import 'package:tft_guide/domain/models/rank/rank.dart';

// ignore: one_member_abstracts, for clarity and potential future extensibility.
abstract interface class RankRepository {
  const RankRepository();

  RankOld computeRank(int elo);
}

abstract interface class RankApi {
  const RankApi();

  int computeLp(int elo);

  Rank computeRank(int elo);
}

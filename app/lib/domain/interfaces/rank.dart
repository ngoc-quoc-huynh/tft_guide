import 'package:tft_guide/domain/models/rank.dart';

// ignore: one_member_abstracts, for clarity and potential future extensibility.
abstract interface class RankRepository {
  const RankRepository();

  Rank computeRank(int elo);
}

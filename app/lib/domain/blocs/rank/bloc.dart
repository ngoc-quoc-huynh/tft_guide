import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/rank/rank.dart';
import 'package:tft_guide/injector.dart';

part 'state.dart';

final class RankCubit extends Cubit<RankState> {
  RankCubit() : super(const RankLoadInProgress());

  static final _rankApi = Injector.instance.rankApi;

  void compute(int elo) {
    final lp = _rankApi.computeLp(elo);
    final rank = _rankApi.computeRank(elo);
    emit(RankLoadOnSuccess(rank: rank, lp: lp));
  }
}

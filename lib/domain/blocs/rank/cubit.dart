import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/rank.dart';
import 'package:tft_guide/injector.dart';

final class RankCubit extends Cubit<Rank?> {
  RankCubit() : super(null);

  final _rankRepository = Injector.instance.rankRepository;

  void compute(int elo) => emit(_rankRepository.computeRank(elo));
}

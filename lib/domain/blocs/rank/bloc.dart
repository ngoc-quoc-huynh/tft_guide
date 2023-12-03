import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/domain/models/rank.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/messages.i18n.dart';
import 'package:tft_guide/static/resources/assets.dart';

part 'event.dart';
part 'state.dart';

// TODO: Optimize Code
final class RankBloc extends Bloc<RankEvent, RankState> {
  RankBloc() : super(const RankLoadInProgress()) {
    on<RankUpdateEvent>(_onRankUpdateEvent);
  }

  void _onRankUpdateEvent(
    RankUpdateEvent event,
    Emitter<RankState> emit,
  ) {
    final elo = event.elo;
    Rank rank;
    switch (elo) {
      case < 400:
        final name = _messages.iron;
        final number = _computeDivisionNumber(elo);
        rank = Rank(
          name: name,
          number: number,
          asset: switch (number) {
            1 => Assets.iron1,
            2 => Assets.iron2,
            3 => Assets.iron3,
            _ => Assets.iron4,
          },
        );
      case < 800:
        final name = _messages.bronze;
        final number = _computeDivisionNumber(elo);
        rank = Rank(
          name: name,
          number: number,
          asset: switch (number) {
            1 => Assets.bronze1,
            2 => Assets.bronze2,
            3 => Assets.bronze3,
            _ => Assets.bronze4,
          },
        );

      case < 1200:
        final name = _messages.silver;
        final number = _computeDivisionNumber(elo);
        rank = Rank(
          name: name,
          number: number,
          asset: switch (number) {
            1 => Assets.silver1,
            2 => Assets.silver2,
            3 => Assets.silver3,
            _ => Assets.silver4,
          },
        );
      case < 1600:
        final name = _messages.gold;
        final number = _computeDivisionNumber(elo);
        rank = Rank(
          name: name,
          number: number,
          asset: switch (number) {
            1 => Assets.gold1,
            2 => Assets.gold2,
            3 => Assets.gold3,
            _ => Assets.gold4,
          },
        );
      case < 2000:
        final name = _messages.emerald;
        final number = _computeDivisionNumber(elo);
        rank = Rank(
          name: name,
          number: number,
          asset: switch (number) {
            1 => Assets.emerald1,
            2 => Assets.emerald2,
            3 => Assets.emerald3,
            _ => Assets.emerald4,
          },
        );
      case < 2400:
        final name = _messages.platinum;
        final number = _computeDivisionNumber(elo);
        rank = Rank(
          name: name,
          number: number,
          asset: switch (number) {
            1 => Assets.platinum1,
            2 => Assets.platinum2,
            3 => Assets.platinum3,
            _ => Assets.platinum4,
          },
        );
      case < 2800:
        final name = _messages.diamond;
        final number = _computeDivisionNumber(elo);
        rank = Rank(
          name: name,
          number: number,
          asset: switch (number) {
            1 => Assets.diamond1,
            2 => Assets.diamond2,
            3 => Assets.diamond3,
            _ => Assets.diamond4,
          },
        );
      case < 3200:
        final name = _messages.master;
        final number = _computeDivisionNumber(elo);
        rank = Rank(
          name: name,
          number: number,
          asset: switch (number) {
            1 => Assets.master1,
            2 => Assets.master2,
            3 => Assets.master3,
            _ => Assets.master4,
          },
        );
      // Master
      case < 3600:
        final name = _messages.grandmaster;
        final number = _computeDivisionNumber(elo);
        rank = Rank(
          name: name,
          number: number,
          asset: switch (number) {
            1 => Assets.grandmaster1,
            2 => Assets.grandmaster2,
            3 => Assets.grandmaster3,
            _ => Assets.grandmaster4,
          },
        );
      default:
        final name = _messages.challenger;
        final number = switch (elo) {
          < 3900 => _computeDivisionNumber(elo),
          _ => 1,
        };
        rank = Rank(
          name: name,
          number: number,
          asset: switch (number) {
            1 => Assets.challenger1,
            2 => Assets.challenger2,
            3 => Assets.challenger3,
            _ => Assets.challenger4,
          },
        );
    }
    final lp = switch (elo) {
      < 4000 => elo % 100,
      _ => elo - 3900,
    };

    emit(RankLoadOnSuccess(rank: rank, lp: lp));
  }

  int _computeDivisionNumber(int elo) {
    final eloWithinDivision = elo % 400;
    return 4 - (eloWithinDivision / 100).ceil();
  }

  DivisionsRankedPagesMessages get _messages =>
      Injector.instance.messages.pages.ranked.divisions;
}

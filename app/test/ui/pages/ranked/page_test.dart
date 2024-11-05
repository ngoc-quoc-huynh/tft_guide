import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/models/rank/division.dart';
import 'package:tft_guide/domain/models/rank/rank.dart';
import 'package:tft_guide/domain/models/rank/tier.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/assets.dart';
import 'package:tft_guide/ui/pages/ranked/page.dart';

import '../../../mocks.dart';
import '../../../utils.dart';

Future<void> main() async {
  final rankApi = MockRankApi();

  setUpAll(
    () => Injector.instance
      ..registerSingleton<Translations>(AppLocale.en.buildSync())
      ..registerSingleton<RankApi>(rankApi),
  );

  tearDownAll(
    () async => Injector.instance
      ..unregister<Translations>()
      ..unregister<RankApi>(),
  );

  final hydratedEloCubit = MockHydratedEloCubit();
  whenListen<int>(
    hydratedEloCubit,
    const Stream<int>.empty(),
    initialState: 0,
  );

  when(() => rankApi.computeLp(0)).thenReturn(0);
  when(() => rankApi.computeRank(0)).thenReturn(
    Rank(
      tier: Tier.iron,
      division: Division.four,
      asset: Assets.iron4,
    ),
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'ranked',
    constraints: pageConstraints(height: 650),
    pumpBeforeTest: (tester) async {
      await precacheImages(tester);
      await tester.pumpAndSettle();
    },
    builder: () {
      final eloGainCubit = MockNumValueCubit<int?>();
      return _TestWidget(
        hydratedEloCubit: hydratedEloCubit,
        eloGainCubit: eloGainCubit,
        mockEloGain: () => whenListen<int?>(
          eloGainCubit,
          const Stream<int?>.empty(),
        ),
      );
    },
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'ranked_elo_gain',
    constraints: pageConstraints(height: 650),
    pumpBeforeTest: (tester) async {
      await precacheImages(tester);
      await tester.pumpAndSettle();
    },
    builder: () {
      final eloGainCubit = MockNumValueCubit<int?>();
      return _TestWidget(
        hydratedEloCubit: hydratedEloCubit,
        eloGainCubit: eloGainCubit,
        mockEloGain: () => whenListen<int?>(
          eloGainCubit,
          const Stream<int?>.empty(),
          initialState: 10,
        ),
      );
    },
  );
}

class _TestWidget extends StatelessWidget {
  const _TestWidget({
    required this.hydratedEloCubit,
    required this.eloGainCubit,
    required this.mockEloGain,
  });

  final HydratedEloCubit hydratedEloCubit;
  final EloGainCubit eloGainCubit;
  final VoidCallback mockEloGain;

  @override
  Widget build(BuildContext context) {
    mockEloGain.call();
    return MultiBlocProvider(
      providers: [
        BlocProvider<HydratedEloCubit>.value(
          value: hydratedEloCubit,
        ),
        BlocProvider<EloGainCubit>.value(
          value: eloGainCubit,
        ),
      ],
      child: const RankedPage(),
    );
  }
}

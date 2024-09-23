import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/rank/bloc.dart';
import 'package:tft_guide/domain/interfaces/rank.dart';
import 'package:tft_guide/domain/models/asset.dart';
import 'package:tft_guide/domain/models/rank/division.dart';
import 'package:tft_guide/domain/models/rank/rank.dart';
import 'package:tft_guide/domain/models/rank/tier.dart';
import 'package:tft_guide/injector.dart';

import '../../mocks.dart';

void main() {
  final rankApi = MockRankApi();

  setUpAll(
    () => Injector.instance.registerSingleton<RankApi>(rankApi),
  );

  tearDownAll(
    () async => Injector.instance.unregister<RankApi>(),
  );

  test(
    'initial state is RankLoadInProgress',
    () => expect(
      RankCubit().state,
      const RankLoadInProgress(),
    ),
  );

  group('compute', () {
    blocTest<RankCubit, RankState>(
      'emits RankLoadOnSuccess.',
      setUp: () {
        when(() => rankApi.computeLp(0)).thenReturn(0);
        when(() => rankApi.computeRank(0)).thenReturn(
          Rank(
            tier: Tier.iron,
            division: Division.four,
            asset: Asset(''),
          ),
        );
      },
      build: RankCubit.new,
      act: (cubit) => cubit.compute(0),
      expect: () => [
        RankLoadOnSuccess(
          rank: Rank(
            tier: Tier.iron,
            division: Division.four,
            asset: Asset(''),
          ),
          lp: 0,
        ),
      ],
      verify: (cubit) => verify(() => rankApi.computeLp(0)),
    );
  });
}

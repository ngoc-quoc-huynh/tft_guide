import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/elo/cubit.dart';

import '../../mocks.dart';

// ignore_for_file: discarded_futures, mocked methods should be futures.

void main() {
  final storage = MockStorage();

  setUpAll(
    () {
      when(
        () => storage.write(any(), any<dynamic>()),
      ).thenAnswer((_) => Future.value());
      HydratedBloc.storage = storage;
    },
  );

  tearDownAll(() => HydratedBloc.storage = null);

  test('initial state is 0', () => expect(EloCubit().state, 0));

  group('increase', () {
    blocTest<EloCubit, int>(
      'emits new state.',
      build: EloCubit.new,
      act: (cubit) => cubit.increase(1),
      expect: () => const [1],
    );
  });

  group('reset', () {
    blocTest<EloCubit, int>(
      'emits nothing when state was 0.',
      build: EloCubit.new,
      seed: () => 0,
      act: (cubit) => cubit.reset(),
      expect: () => const <int>[],
    );

    blocTest<EloCubit, int>(
      'emits 0 when state was not 0.',
      build: EloCubit.new,
      seed: () => 1,
      act: (cubit) => cubit.reset(),
      expect: () => const [0],
    );
  });

  group('fromJson', () {
    test(
      'returns correctly.',
      () => expect(
        EloCubit().fromJson({'elo': 0}),
        0,
      ),
    );
  });

  group('toJson', () {
    test(
      'returns correctly.',
      () => expect(
        EloCubit().toJson(0),
        {'elo': 0},
      ),
    );
  });
}

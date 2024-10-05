import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/blocs/admin/cubit.dart';

void main() {
  test(
    'initial state is AdminDisabled',
    () => expect(AdminCubit(1).state, const AdminDisabled()),
  );

  group('click', () {
    blocTest<AdminCubit, AdminState>(
      'emits nothing when state was AdminEnabled.',
      build: () => AdminCubit(1),
      seed: () => const AdminEnabled(),
      act: (cubit) => cubit.click(),
      expect: () => const <AdminState>[],
    );

    blocTest<AdminCubit, AdminState>(
      'emits AdminEnabled when state was AdminLoadInProgress and clicks will be'
      ' amount of clicks to enable admin.',
      build: () => AdminCubit(1),
      seed: () => const AdminLoadInProgress(0),
      act: (cubit) => cubit.click(),
      expect: () => const [AdminEnabled()],
    );

    blocTest<AdminCubit, AdminState>(
      'emits AdminLoadInProgress when state was AdminLoadInProgress and clicks'
      ' will not be amount of clicks to enable admin.',
      build: () => AdminCubit(2),
      seed: () => const AdminLoadInProgress(0),
      act: (cubit) => cubit.click(),
      expect: () => const [AdminLoadInProgress(1)],
    );

    blocTest<AdminCubit, AdminState>(
      'emits AdminLoadInProgress when state was AdminDisabled.',
      build: () => AdminCubit(1),
      seed: () => const AdminDisabled(),
      act: (cubit) => cubit.click(),
      expect: () => const [AdminLoadInProgress(1)],
    );

    blocTest<AdminCubit, AdminState>(
      'emits AdminDisabled when timer is finished.',
      build: () => AdminCubit(1),
      act: (cubit) => cubit.click(),
      wait: const Duration(seconds: 1),
      expect: () => const [
        AdminLoadInProgress(1),
        AdminDisabled(),
      ],
    );
  });
}

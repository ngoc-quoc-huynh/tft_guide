part of '../cubit.dart';

@visibleForTesting
base mixin TestNumValueCubit<State extends num?>
    implements NumValueCubit<State> {}

final class NumValueCubit<State extends num?> extends ValueCubit<State> {
  NumValueCubit(super.initialState);

  void increase() => emit(((state ?? 0) + 1) as State);
}

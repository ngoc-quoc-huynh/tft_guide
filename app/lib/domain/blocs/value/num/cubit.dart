part of '../cubit.dart';

@visibleForTesting
base mixin TestNumValueCubit<T extends num?> implements NumValueCubit<T> {}

final class NumValueCubit<T extends num?> extends ValueCubit<T> {
  NumValueCubit(super.initialState);

  void increase() => emit(((state ?? 0) + 1) as T);
}

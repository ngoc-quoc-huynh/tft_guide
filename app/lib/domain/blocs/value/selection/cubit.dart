part of '../cubit.dart';

@visibleForTesting
base mixin TestSelectionValueCubitMixin<T> implements SelectionValueCubit<T> {}

final class SelectionValueCubit<T> extends ValueCubit<T?> {
  SelectionValueCubit() : super(null);

  void select(T option) => emit(
        switch (state == option) {
          true => null,
          false => option,
        },
      );
}

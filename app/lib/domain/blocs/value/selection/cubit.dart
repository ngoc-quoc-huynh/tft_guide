part of '../cubit.dart';

@visibleForTesting
base mixin TestSelectionValueCubitMixin<State>
    implements SelectionValueCubit<State> {}

final class SelectionValueCubit<State> extends ValueCubit<State?> {
  SelectionValueCubit() : super(null);

  void select(State option) => emit(
        switch (state == option) {
          true => null,
          false => option,
        },
      );
}

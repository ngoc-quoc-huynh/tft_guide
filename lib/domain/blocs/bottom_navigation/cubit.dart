import 'package:flutter_bloc/flutter_bloc.dart';

part 'state.dart';

final class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationState.ranked);

  void switchStateTo(BottomNavigationState state) => emit(state);
}

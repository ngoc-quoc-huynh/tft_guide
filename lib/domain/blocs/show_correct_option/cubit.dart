import 'package:flutter_bloc/flutter_bloc.dart';

final class ShowCorrectOptionCubit extends Cubit<bool> {
  ShowCorrectOptionCubit() : super(false);

  void show() => emit(true);

  void clear() => emit(false);
}

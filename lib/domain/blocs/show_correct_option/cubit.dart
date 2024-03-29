import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: Maybe refactor to a value cubit
final class ShowCorrectOptionCubit extends Cubit<bool> {
  ShowCorrectOptionCubit() : super(false);

  void show() => emit(true);
}

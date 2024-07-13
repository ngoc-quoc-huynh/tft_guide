import 'package:flutter_bloc/flutter_bloc.dart';

final class EloGainCubit extends Cubit<int?> {
  EloGainCubit() : super(null);

  void gain(int? n) => emit(n);
}

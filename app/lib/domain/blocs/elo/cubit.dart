import 'package:hydrated_bloc/hydrated_bloc.dart';

final class EloCubit extends HydratedCubit<int> {
  EloCubit() : super(0);

  void increase(int n) => emit(state + n);

  void reset() => emit(0);

  @override
  int fromJson(Map<String, dynamic> json) => json['elo'] as int;

  @override
  Map<String, int> toJson(int state) => {'elo': state};
}

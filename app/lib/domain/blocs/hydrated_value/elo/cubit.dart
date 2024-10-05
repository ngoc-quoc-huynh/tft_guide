part of '../cubit.dart';

final class HydratedEloCubit extends HydratedValueCubit<int> {
  HydratedEloCubit() : super(0);

  void increase(int n) => emit(state + n);

  void reset() => emit(0);

  @override
  int fromJson(Map<String, dynamic> json) => json['elo'] as int;

  @override
  Map<String, int> toJson(int state) => {'elo': state};
}

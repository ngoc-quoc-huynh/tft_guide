part of 'cubit.dart';

@immutable
sealed class BrightnessState extends Equatable {
  const BrightnessState();

  @override
  List<Object?> get props => [];
}

final class BrightnessInitial extends BrightnessState {
  const BrightnessInitial();
}

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tft_guide/injector.dart';

part 'state.dart';

final class FeedbackCubit extends Cubit<String?> {
  FeedbackCubit() : super(null);
  final _feedbackAPI = Injector.instance.feedbackAPI;

  void getFeedback({required bool isCorrect}) =>
      emit(_feedbackAPI.getFeedback(isCorrect: isCorrect));
}
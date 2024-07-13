abstract interface class FeedbackAPI {
  const FeedbackAPI();

  String getFeedback({required bool isCorrect});
}

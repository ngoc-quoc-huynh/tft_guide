// ignore: one_member_abstracts, for clarity and potential future extensibility.
abstract interface class FeedbackAPI {
  const FeedbackAPI();

  String getFeedback({required bool isCorrect});
}

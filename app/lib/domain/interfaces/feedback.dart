// ignore: one_member_abstracts, for clarity and potential future extensibility.
abstract interface class FeedbackApi {
  const FeedbackApi();

  String getFeedback({required bool isCorrect});
}

// ignore: one_member_abstracts, for clarity and potential future extensibility.
abstract interface class AdminApi {
  const AdminApi();

  bool checkPassword(String password);
}

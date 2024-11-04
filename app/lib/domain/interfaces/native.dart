// ignore: one_member_abstracts, for clarity and potential future extensibility.
abstract class NativeApi {
  const NativeApi._();

  Future<void> openUrl(Uri url);

  Future<void> openFile(String path);

  Future<void> restartApp();
}

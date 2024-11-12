import 'package:tft_guide/domain/interfaces/admin.dart';

final class MockAdminApi implements AdminApi {
  const MockAdminApi();

  @override
  bool checkPassword(String password) => true;
}

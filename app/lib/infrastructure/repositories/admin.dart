import 'package:tft_guide/domain/interfaces/admin.dart';

final class AdminRepository implements AdminApi {
  const AdminRepository(this._password);

  final String _password;

  @override
  bool checkPassword(String password) => _password == password;
}

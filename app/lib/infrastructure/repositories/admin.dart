import 'package:tft_guide/domain/interfaces/admin.dart';
import 'package:tft_guide/domain/utils/mixins/logger.dart';

final class AdminRepository with LoggerMixin implements AdminApi {
  const AdminRepository(this._password);

  final String _password;

  @override
  bool checkPassword(String password) {
    const methodName = 'AdminRepository.checkPassword';
    final parameters = {'password': password};

    if (_password == password) {
      logInfo(
        methodName,
        'Password is correct.',
        parameters: parameters,
        stackTrace: StackTrace.current,
      );
      return true;
    }
    logWarning(
      methodName,
      'Password is incorrect.',
      parameters: parameters,
      stackTrace: StackTrace.current,
    );
    return false;
  }
}

import 'package:tft_guide/domain/exceptions/base.dart';

sealed class LocalDatabaseException extends CustomException {
  const LocalDatabaseException();
}

final class ElementNotFoundException extends LocalDatabaseException {
  const ElementNotFoundException();
}

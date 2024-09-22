import 'package:tft_guide/domain/exceptions/base.dart';

sealed class RemoteDatabaseException extends CustomException {
  const RemoteDatabaseException();
}

final class InvalidUrlException extends RemoteDatabaseException {
  const InvalidUrlException();
}

final class NoConnectionException extends RemoteDatabaseException {
  const NoConnectionException();
}

final class AssetNotFoundException extends RemoteDatabaseException {
  const AssetNotFoundException();
}

final class BucketNotFoundException extends RemoteDatabaseException {
  const BucketNotFoundException();
}

final class TableNotFoundException extends RemoteDatabaseException {
  const TableNotFoundException();
}

final class FunctionNotFoundException extends RemoteDatabaseException {
  const FunctionNotFoundException();
}

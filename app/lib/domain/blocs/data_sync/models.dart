part of 'bloc.dart';

@immutable
final class _SyncOperation {
  const _SyncOperation({
    required this.loadLatestUpdatedAt,
    required this.loadData,
    required this.storeData,
  });

  final FutureOr<DateTime?> loadLatestUpdatedAt;
  final Future<Object> Function(DateTime?) loadData;
  final Future<void> Function(Object) storeData;
}

@immutable
final class _SyncOperationResult {
  const _SyncOperationResult({
    required this.latestUpdatedAt,
    required this.loadData,
    required this.storeData,
  });

  final DateTime? latestUpdatedAt;
  final Future<Object> Function(DateTime?) loadData;
  final Future<void> Function(Object) storeData;
}

@immutable
final class _SyncItem {
  const _SyncItem({
    required this.result,
    required this.storeData,
  });

  // ignore: no-object-declaration, we do not know the type yet.
  final Object result;
  final Future<void> Function(Object) storeData;
}

part of 'bloc.dart';

@immutable
final class _RepairOperation {
  const _RepairOperation({
    required this.loadData,
    required this.storeData,
  });

  final Future<Object> Function(DateTime?) loadData;
  final Future<void> Function(Object) storeData;
}

@immutable
final class _RepairItem {
  const _RepairItem({
    required this.result,
    required this.storeData,
  });

  // ignore: no-object-declaration, we do not know the type yet.
  final Object result;
  final Future<void> Function(Object) storeData;
}

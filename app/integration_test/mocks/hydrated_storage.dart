import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';

final class MockHydratedStorage implements Storage {
  const MockHydratedStorage();

  static const _storage = <String, String?>{
    'HydratedEloCubit': '{"elo":399}',
    'HydratedTranslationLocaleCubit': '{"language":"en"}',
    'HydratedThemeModeCubit': '{"theme_mode":"dark"}',
  };

  @override
  // ignore: avoid-dynamic, since it is the method signature.
  dynamic read(String key) => switch (_storage[key]) {
        null => null,
        final String value => jsonDecode(value),
      };

  @override
  // ignore: avoid-dynamic, since it is the method signature.
  Future<void> write(String key, dynamic value) async => _storage.putIfAbsent(
        key,
        () => jsonEncode(value),
      );

  @override
  Future<void> delete(String key) async => _storage.remove(key);

  @override
  Future<void> clear() async => _storage.clear();

  @override
  Future<void> close() => Future.value();
}

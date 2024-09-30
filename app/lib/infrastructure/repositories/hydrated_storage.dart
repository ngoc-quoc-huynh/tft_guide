import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tft_guide/injector.dart';

@immutable
final class SharedPrefsHydratedStorage implements Storage {
  const SharedPrefsHydratedStorage();

  static final _sharedPrefs = Injector.instance.sharedPrefs;

  @override
  // ignore: avoid-dynamic, since it is the method signature.
  dynamic read(String key) {
    final value = _sharedPrefs.getString(key);
    return switch (value) {
      null => null,
      String() => jsonDecode(value),
    };
  }

  @override
  // ignore: avoid-dynamic, since it is the method signature.
  Future<void> write(String key, dynamic value) => _sharedPrefs.setString(
        key,
        jsonEncode(value),
      );

  @override
  Future<void> delete(String key) => _sharedPrefs.remove(key);

  @override
  Future<void> clear() => _sharedPrefs.clear();

  @override
  Future<void> close() async {
    return;
  }
}

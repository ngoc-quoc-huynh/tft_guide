import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tft_guide/injector.dart';

class SharedPrefsHydratedStorage implements Storage {
  const SharedPrefsHydratedStorage();

  static final _sharedPrefs = Injector.instance.sharedPrefs;

  @override
  dynamic read(String key) {
    final value = _sharedPrefs.getString(key);
    return switch (value) {
      null => null,
      String() => jsonDecode(value),
    };
  }

  @override
  Future<void> write(String key, dynamic value) async => _sharedPrefs.setString(
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

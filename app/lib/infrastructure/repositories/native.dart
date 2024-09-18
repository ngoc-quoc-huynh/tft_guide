import 'package:restart/restart.dart';
import 'package:tft_guide/domain/interfaces/native.dart';

final class NativeRepository implements NativeApi {
  const NativeRepository();

  @override
  Future<void> restartApp() => restart();
}

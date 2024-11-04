import 'package:flutter/foundation.dart';
import 'package:open_filex/open_filex.dart';
import 'package:restart/restart.dart';
import 'package:tft_guide/domain/interfaces/native.dart';
import 'package:url_launcher/url_launcher.dart';

@immutable
final class NativeRepository implements NativeApi {
  const NativeRepository();

  @override
  Future<void> openUrl(Uri url) => launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

  @override
  Future<void> openFile(String path) => OpenFilex.open(path);

  @override
  Future<void> restartApp() => restart();
}

import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/theme.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async =>
    AlchemistConfig.runWithConfig(
      config: AlchemistConfig(
        theme: CustomTheme.lightTheme(const TextTheme()),
        platformGoldensConfig: const PlatformGoldensConfig(
          // ignore: avoid_redundant_argument_values, will be true running on CI.
          enabled: !bool.fromEnvironment('CI'),
        ),
      ),
      run: testMain,
    );

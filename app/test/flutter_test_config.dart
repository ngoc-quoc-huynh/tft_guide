import 'dart:async';

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:tft_guide/static/resources/theme.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async =>
    AlchemistConfig.runWithConfig(
      config: AlchemistConfig(
        theme: CustomTheme.lightTheme(const TextTheme()),
      ),
      run: testMain,
    );

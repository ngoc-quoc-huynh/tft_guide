import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/design.dart';

import '../../../../mocks.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance
        .registerSingleton<Translations>(TranslationsEn.build()),
  );

  tearDownAll(Injector.instance.unregister<Translations>);

  final hydratedThemeModeCubit = MockHydratedThemeModeCubit();
  whenListen<ThemeMode>(
    hydratedThemeModeCubit,
    const Stream<ThemeMode>.empty(),
    initialState: ThemeMode.system,
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'design',
    builder: () => BlocProvider<HydratedThemeModeCubit>.value(
      value: hydratedThemeModeCubit,
      child: const SettingsDesignDialog(),
    ),
  );
}

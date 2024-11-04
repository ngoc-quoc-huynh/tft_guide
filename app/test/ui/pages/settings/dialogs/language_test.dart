import 'package:alchemist/alchemist.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/pages/settings/dialogs/language.dart';

import '../../../../mocks.dart';

Future<void> main() async {
  setUpAll(
    () => Injector.instance
        .registerSingleton<Translations>(TranslationsEn.build()),
  );

  tearDownAll(Injector.instance.unregister<Translations>);

  final hydratedTranslationLocaleCubit = MockHydratedTranslationLocaleCubit();
  whenListen<TranslationLocale>(
    hydratedTranslationLocaleCubit,
    const Stream<TranslationLocale>.empty(),
    initialState: TranslationLocale.system,
  );

  await goldenTest(
    'renders correctly.',
    fileName: 'language',
    builder: () => BlocProvider<HydratedTranslationLocaleCubit>.value(
      value: hydratedTranslationLocaleCubit,
      child: const SettingsLanguageDialog(),
    ),
  );
}

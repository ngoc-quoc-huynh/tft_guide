import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/interfaces/widgets_binding.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/language/provider.dart';
import 'package:tft_guide/ui/widgets/widget_observer.dart';

import '../../../mocks.dart';

void main() {
  testWidgets(
    'returns LanguageCode.de when TranslationLocale.german is emitted.',
    (tester) async {
      final cubit = MockHydratedTranslationLocaleCubit();
      whenListen<TranslationLocale>(
        cubit,
        Stream.value(TranslationLocale.german),
        initialState: TranslationLocale.english,
      );
      await tester.pumpWidget(
        BlocProvider<HydratedTranslationLocaleCubit>.value(
          value: cubit,
          child: LanguageProvider(
            locale: TranslationLocale.german,
            child: Builder(
              builder: (context) {
                expect(
                  context.read<LanguageCodeValueCubit>().state,
                  LanguageCode.de,
                );
                expect(
                  Injector.instance.isRegistered<Translations>(),
                  isTrue,
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    },
  );

  testWidgets(
    'returns LanguageCode.en when TranslationLocale.english is emitted.',
    (tester) async {
      final cubit = MockHydratedTranslationLocaleCubit();
      whenListen<TranslationLocale>(
        cubit,
        Stream.value(TranslationLocale.english),
        initialState: TranslationLocale.german,
      );
      await tester.pumpWidget(
        BlocProvider<HydratedTranslationLocaleCubit>.value(
          value: cubit,
          child: LanguageProvider(
            locale: TranslationLocale.english,
            child: Builder(
              builder: (context) {
                expect(
                  context.read<LanguageCodeValueCubit>().state,
                  LanguageCode.en,
                );
                expect(
                  Injector.instance.isRegistered<Translations>(),
                  isTrue,
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    },
  );

  testWidgets(
    'returns LanguageCode.en when state was TranslationLocale.system and '
    'didChangeLocales will be triggered.',
    (tester) async {
      final cubit = MockHydratedTranslationLocaleCubit();
      whenListen<TranslationLocale>(
        cubit,
        Stream.value(TranslationLocale.system),
        initialState: TranslationLocale.german,
      );

      final widgetsBindingApi = MockWidgetsBindingApi();
      Injector.instance.registerSingleton<WidgetsBindingApi>(widgetsBindingApi);
      addTearDown(Injector.instance.unregister<WidgetsBindingApi>);
      when(() => widgetsBindingApi.locale).thenReturn(const Locale('en'));

      await tester.pumpWidget(
        BlocProvider<HydratedTranslationLocaleCubit>.value(
          value: cubit,
          child: LanguageProvider(
            locale: TranslationLocale.system,
            child: Builder(
              builder: (context) {
                expect(
                  context.read<LanguageCodeValueCubit>().state,
                  LanguageCode.en,
                );
                expect(
                  Injector.instance.isRegistered<Translations>(),
                  isTrue,
                );
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    },
  );

  testWidgets(
    'returns LanguageCode.en when .',
    (tester) async {
      final cubit = MockHydratedTranslationLocaleCubit();
      whenListen<TranslationLocale>(
        cubit,
        const Stream<TranslationLocale>.empty(),
        initialState: TranslationLocale.system,
      );

      final widgetsBindingApi = MockWidgetsBindingApi();
      Injector.instance.registerSingleton<WidgetsBindingApi>(widgetsBindingApi);
      addTearDown(Injector.instance.unregister<WidgetsBindingApi>);
      when(() => widgetsBindingApi.locale).thenReturn(const Locale('en'));

      await tester.pumpWidget(
        BlocProvider<HydratedTranslationLocaleCubit>.value(
          value: cubit,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: LanguageProvider(
              locale: TranslationLocale.system,
              child: Builder(
                builder: (context) => Text(
                  context.read<LanguageCodeValueCubit>().state.toString(),
                ),
              ),
            ),
          ),
        ),
      );
      tester
          .state<WidgetObserverState>(find.byType(WidgetObserver))
          .didChangeLocales([const Locale('en')]);
      await tester.pump();
      expect(find.text('LanguageCode.en'), findsOneWidget);
    },
  );
}

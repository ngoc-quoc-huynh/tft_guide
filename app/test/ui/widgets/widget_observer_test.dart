import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/interfaces/widgets_binding.dart';
import 'package:tft_guide/domain/models/database/language_code.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/ui/widgets/widget_observer.dart';

import '../../mocks.dart';

// ignore_for_file: missing-test-assertion, verify is sufficient.

void main() {
  final widgetsBindingApi = MockWidgetsBindingApi();

  setUpAll(
    () => Injector.instance
        .registerSingleton<WidgetsBindingApi>(widgetsBindingApi),
  );

  tearDownAll(() async => Injector.instance.unregister<WidgetsBindingApi>());

  group('didChangePlatformBrightness', () {
    testWidgets('returns nothing if theme mode is dark.', (tester) async {
      final mockThemeCubit = MockHydratedThemeModeCubit();
      whenListen<ThemeMode>(
        mockThemeCubit,
        const Stream<ThemeMode>.empty(),
        initialState: ThemeMode.dark,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HydratedThemeModeCubit>.value(
            value: mockThemeCubit,
            child: const WidgetObserver(
              child: SizedBox.shrink(),
            ),
          ),
        ),
      );

      WidgetsBinding.instance.handlePlatformBrightnessChanged();
      await tester.pump();
      verifyNever(() => widgetsBindingApi.brightness);
    });

    testWidgets('returns nothing if theme mode is light.', (tester) async {
      final mockThemeCubit = MockHydratedThemeModeCubit();
      whenListen<ThemeMode>(
        mockThemeCubit,
        const Stream<ThemeMode>.empty(),
        initialState: ThemeMode.light,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<HydratedThemeModeCubit>.value(
            value: mockThemeCubit,
            child: const WidgetObserver(
              child: SizedBox.shrink(),
            ),
          ),
        ),
      );

      WidgetsBinding.instance.handlePlatformBrightnessChanged();
      await tester.pump();
      verifyNever(() => widgetsBindingApi.brightness);
    });

    testWidgets(
      'returns correct brightness if theme mode is system.',
      (tester) async {
        final mockThemeCubit = MockHydratedThemeModeCubit();
        whenListen<ThemeMode>(
          mockThemeCubit,
          const Stream<ThemeMode>.empty(),
          initialState: ThemeMode.system,
        );
        when(() => widgetsBindingApi.brightness).thenReturn(Brightness.dark);

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<HydratedThemeModeCubit>.value(
              value: mockThemeCubit,
              child: WidgetObserver(
                child: const SizedBox.shrink(),
                onBrightnessChanged: (brightness) =>
                    expect(brightness, Brightness.dark),
              ),
            ),
          ),
        );

        WidgetsBinding.instance.handlePlatformBrightnessChanged();
        await tester.pump();
        verify(() => widgetsBindingApi.brightness).called(1);
      },
    );
  });

  group('didChangeLocales', () {
    testWidgets(
      'returns nothing if translation locale is english.',
      (tester) async {
        final mockTranslationLocaleCubit = MockHydratedTranslationLocaleCubit();
        whenListen<TranslationLocale>(
          mockTranslationLocaleCubit,
          const Stream<TranslationLocale>.empty(),
          initialState: TranslationLocale.english,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<HydratedTranslationLocaleCubit>.value(
              value: mockTranslationLocaleCubit,
              child: const WidgetObserver(
                child: SizedBox.shrink(),
              ),
            ),
          ),
        );

        tester
            .state<WidgetObserverState>(find.byType(WidgetObserver))
            .didChangeLocales([const Locale('en')]);
        await tester.pump();
        verifyNever(() => widgetsBindingApi.locale);
      },
    );

    testWidgets(
      'returns nothing if translation locale is german.',
      (tester) async {
        final mockTranslationLocaleCubit = MockHydratedTranslationLocaleCubit();
        whenListen<TranslationLocale>(
          mockTranslationLocaleCubit,
          const Stream<TranslationLocale>.empty(),
          initialState: TranslationLocale.german,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<HydratedTranslationLocaleCubit>.value(
              value: mockTranslationLocaleCubit,
              child: const WidgetObserver(
                child: SizedBox.shrink(),
              ),
            ),
          ),
        );

        tester
            .state<WidgetObserverState>(find.byType(WidgetObserver))
            .didChangeLocales([const Locale('en')]);
        await tester.pump();
        verifyNever(() => widgetsBindingApi.locale);
      },
    );

    testWidgets(
      'returns correct locale if translation locale is system.',
      (tester) async {
        final mockTranslationLocaleCubit = MockHydratedTranslationLocaleCubit();
        whenListen<TranslationLocale>(
          mockTranslationLocaleCubit,
          const Stream<TranslationLocale>.empty(),
          initialState: TranslationLocale.system,
        );
        when(() => widgetsBindingApi.locale).thenReturn(const Locale('en'));

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<HydratedTranslationLocaleCubit>.value(
              value: mockTranslationLocaleCubit,
              child: WidgetObserver(
                child: const SizedBox.shrink(),
                onLanguageChanged: (languageCode) =>
                    expect(languageCode, LanguageCode.en),
              ),
            ),
          ),
        );

        tester
            .state<WidgetObserverState>(find.byType(WidgetObserver))
            .didChangeLocales([const Locale('en')]);
        await tester.pump();
        verify(() => widgetsBindingApi.locale).called(1);
      },
    );
  });
}

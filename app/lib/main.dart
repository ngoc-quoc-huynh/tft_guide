import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tft_guide/domain/blocs/theme_mode/cubit.dart';
import 'package:tft_guide/domain/blocs/translation_locale/cubit.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/theme.dart';
import 'package:tft_guide/ui/router/config.dart';
import 'package:tft_guide/ui/widgets/custom_skeletonizer_config.dart';

Future<void> main() async {
  // TODO: Preload SVGs
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.setupDependencies();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: Injector.instance.appDir,
  );
  //await initData();

  runApp(const MyApp());
}

// ignore: prefer-static-class, for testing purpose. TODO: Remove this
Future<void> initData() async {
  final stopwatch = Stopwatch()..start();
  final remoteDatabaseApi = Injector.instance.remoteDatabaseApi;
  final (
    baseItems,
    fullItems,
    baseItemTranslations,
    fullItemTranslations,
    assetNames
  ) = await (
    remoteDatabaseApi.loadBaseItems(null),
    remoteDatabaseApi.loadFullItems(null),
    remoteDatabaseApi.loadBaseItemTranslations(null),
    remoteDatabaseApi.loadFullItemTranslations(null),
    remoteDatabaseApi.loadAssetsNames(null)
  ).wait;
  final localDatabaseApi = Injector.instance.localDatabaseApi;
  await [
    localDatabaseApi.storeBaseItems(baseItems),
    localDatabaseApi.storeFullItems(fullItems),
  ].wait;
  await [
    localDatabaseApi.storeBaseItemTranslations(baseItemTranslations),
    localDatabaseApi.storeFullItemTranslations(fullItemTranslations),
  ].wait;
  final fileStorageApi = Injector.instance.fileStorageApi;
  Future<void> download(String name) async {
    final asset = await remoteDatabaseApi.loadAsset(name);
    await fileStorageApi.save(name, asset);
  }

  await assetNames.map(download).wait;
  debugPrint('Downloaded database in ${stopwatch.elapsed}');
  stopwatch.stop();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider<TranslationLocaleCubit>(
          create: (_) => TranslationLocaleCubit(),
        ),
        BlocProvider<ThemeModeCubit>(
          create: (_) => ThemeModeCubit(),
        ),
      ],
      child: BlocBuilder<TranslationLocaleCubit, TranslationLocale?>(
        builder: (context, locale) => BlocBuilder<ThemeModeCubit, ThemeMode>(
          builder: (context, themeMode) => MaterialApp.router(
            title: Injector.instance.translations.appName,
            theme: CustomTheme.lightTheme(textTheme),
            darkTheme: CustomTheme.darkTheme(textTheme),
            themeMode: themeMode,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            locale: switch (locale?.code) {
              null => null,
              final String code => Locale(code),
            },
            supportedLocales: AppLocaleUtils.supportedLocales,
            routerConfig: GoRouterConfig.routes,
            builder: (context, child) => CustomSkeletonizerConfig(
              child: child!,
            ),
          ),
        ),
      ),
    );
  }
}

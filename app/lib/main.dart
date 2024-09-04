import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tft_guide/domain/blocs/data_sync/bloc.dart';
import 'package:tft_guide/domain/blocs/theme_mode/cubit.dart';
import 'package:tft_guide/domain/blocs/translation_locale/cubit.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/infrastructure/repositories/hydrated_storage.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/theme.dart';
import 'package:tft_guide/ui/router/config.dart';
import 'package:tft_guide/ui/widgets/custom_skeletonizer_config.dart';
import 'package:tft_guide/ui/widgets/language/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.setupDependencies();
  HydratedBloc.storage = const SharedPrefsHydratedStorage();
  runApp(const TftApp());
}

class TftApp extends StatelessWidget {
  const TftApp({super.key});

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
        BlocProvider<DataSyncBloc>(
          create: (_) => DataSyncBloc()..add(const DataSyncInitializeEvent()),
        ),
      ],
      child: BlocBuilder<TranslationLocaleCubit, TranslationLocale>(
        builder: (context, locale) => LanguageProvider(
          locale: locale,
          child: BlocBuilder<ThemeModeCubit, ThemeMode>(
            builder: (context, themeMode) => MaterialApp.router(
              title: Injector.instance.translations.appName,
              theme: CustomTheme.lightTheme(textTheme),
              darkTheme: CustomTheme.darkTheme(textTheme),
              themeMode: themeMode,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              locale: switch (locale.code) {
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
      ),
    );
  }
}

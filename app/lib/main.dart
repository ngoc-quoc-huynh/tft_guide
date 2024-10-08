import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tft_guide/domain/blocs/data_sync/bloc.dart';
import 'package:tft_guide/domain/blocs/hydrated_value/cubit.dart';
import 'package:tft_guide/domain/blocs/value/cubit.dart';
import 'package:tft_guide/domain/models/translation_locale.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/theme.dart';
import 'package:tft_guide/ui/router/config.dart';
import 'package:tft_guide/ui/widgets/custom_skeletonizer_config.dart';
import 'package:tft_guide/ui/widgets/language/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.setupDependencies();
  runApp(const TftApp());
}

class TftApp extends StatelessWidget {
  const TftApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider<HydratedTranslationLocaleCubit>(
          create: (_) => HydratedTranslationLocaleCubit(),
        ),
        BlocProvider<HydratedThemeModeCubit>(
          create: (_) => HydratedThemeModeCubit(),
        ),
        BlocProvider<DataSyncBloc>(
          create: (_) => DataSyncBloc()..add(const DataSyncInitializeEvent()),
        ),
        BlocProvider<BoolValueCubit>(
          create: (_) => BoolValueCubit(false),
        ),
      ],
      child: BlocBuilder<HydratedTranslationLocaleCubit, TranslationLocale>(
        builder: (context, locale) => LanguageProvider(
          locale: locale,
          child: BlocBuilder<HydratedThemeModeCubit, ThemeMode>(
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

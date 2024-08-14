import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
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
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocProvider<TranslationLocaleCubit>(
      create: (_) => TranslationLocaleCubit(),
      child: BlocBuilder<TranslationLocaleCubit, TranslationLocale?>(
        builder: (context, locale) => MaterialApp.router(
          title: Injector.instance.translations.appName,
          theme: CustomTheme.lightTheme(textTheme),
          darkTheme: CustomTheme.darkTheme(textTheme),
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
    );
  }
}

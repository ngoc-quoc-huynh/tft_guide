import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tft_guide/domain/blocs/items/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/theme.dart';
import 'package:tft_guide/static/router.dart';

Future<void> main() async {
  // TODO: Preload SVGs
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  Injector.setupDependencies();
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
    return MaterialApp.router(
      title: Injector.instance.translations.appName,
      theme: CustomTheme.lightTheme(textTheme),
      darkTheme: CustomTheme.darkTheme(textTheme),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      locale: Injector.instance.translations.$meta.locale.flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      routerConfig: GoRouterConfig.routes,
      builder: (_, child) => BlocProvider<ItemsBloc>(
        create: (_) => ItemsBloc()..add(const ItemsInitializeEvent()),
        child: child,
      ),
    );
  }
}

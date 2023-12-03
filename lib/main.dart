import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tft_guide/domain/blocs/items/bloc.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/theme.dart';
import 'package:tft_guide/static/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp.router(
      title: Injector.instance.messages.appName,
      theme: CustomTheme.theme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('de', '')],
      routerConfig: GoRouterConfig.routes,
      builder: (_, child) => BlocProvider<ItemsBloc>(
        create: (_) => ItemsBloc()..add(const ItemsInitializeEvent()),
        child: child,
      ),
    );
  }
}

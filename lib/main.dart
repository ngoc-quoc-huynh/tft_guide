import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/resources/theme.dart';
import 'package:tft_guide/static/router.dart';

void main() {
  Injector.setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: Injector.instance.messages.appName,
      theme: CustomTheme.light,
      darkTheme: CustomTheme.dark,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('de', '')],
      routerConfig: GoRouterConfig.routes,
    );
  }
}

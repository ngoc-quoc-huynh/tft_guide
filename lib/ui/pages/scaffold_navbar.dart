import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(_translations.appName),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.quiz),
            label: _pagesTranslations.ranked.title,
          ),
          NavigationDestination(
            icon: const Icon(Icons.format_list_bulleted),
            label: _pagesTranslations.items.title,
          ),
          NavigationDestination(
            icon: const Icon(Icons.format_quote),
            label: _pagesTranslations.settings.title,
          ),
        ],
      ),
      body: navigationShell,
    );
  }

  Translations get _translations => Injector.instance.translations;

  TranslationsPagesDe get _pagesTranslations =>
      Injector.instance.translations.pages;
}

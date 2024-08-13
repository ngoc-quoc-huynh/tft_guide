import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/ui/pages/settings/page.dart';
import 'package:tft_guide/ui/widgets/custom_app_bar.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          IconButton(
            onPressed: () => unawaited(
              context.pushNamed(SettingsPage.routeName),
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
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
            label: _translations.ranked.title,
          ),
          NavigationDestination(
            icon: const Icon(Icons.format_list_bulleted),
            label: _translations.items.title,
          ),
          NavigationDestination(
            icon: const Icon(Icons.format_quote),
            label: _translations.settings.title,
          ),
        ],
      ),
      body: navigationShell,
    );
  }

  TranslationsPagesDe get _translations => Injector.instance.translations.pages;
}

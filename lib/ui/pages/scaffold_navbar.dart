import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/translations.g.dart';
import 'package:tft_guide/static/resources/colors.dart';
import 'package:tft_guide/ui/widgets/background.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(_translations.appName),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: GNav(
          selectedIndex: navigationShell.currentIndex,
          gap: 8,
          iconSize: 20,
          color: Colors.grey[600],
          tabBackgroundColor: Colors.grey[900]!,
          activeColor: CustomColors.orange,
          rippleColor: CustomColors.orange,
          hoverColor: CustomColors.orange,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 400),
          haptic: false,
          onTabChange: (index) => navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          ),
          tabs: [
            GButton(
              icon: LineIcons.lightbulb,
              text: _pagesTranslations.ranked.title,
            ),
            GButton(
              icon: LineIcons.list,
              text: _pagesTranslations.items.title,
            ),
            GButton(
              icon: Icons.settings,
              text: _pagesTranslations.settings.title,
            ),
          ],
        ),
      ),
      body: Background(
        child: SafeArea(
          child: navigationShell,
        ),
      ),
    );
  }

  Translations get _translations => Injector.instance.translations;

  TranslationsPagesDe get _pagesTranslations =>
      Injector.instance.translations.pages;
}

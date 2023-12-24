import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tft_guide/injector.dart';
import 'package:tft_guide/static/i18n/messages.i18n.dart';
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
        title: Text(_messages.appName),
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
              text: _pagesMessages.ranked.title,
            ),
            GButton(
              icon: LineIcons.list,
              text: _pagesMessages.items.title,
            ),
            GButton(
              icon: Icons.settings,
              text: _pagesMessages.settings.title,
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

  Messages get _messages => Injector.instance.messages;

  PagesMessages get _pagesMessages => Injector.instance.messages.pages;
}

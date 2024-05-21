import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
            onPressed: () {
              // TODO: Implement settings
            },
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
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.quiz),
            label: 'Ranked',
          ),
          NavigationDestination(
            icon: Icon(Icons.format_list_bulleted),
            label: 'Items',
          ),
          NavigationDestination(
            icon: Icon(Icons.format_quote),
            label: 'Quotes',
          ),
        ],
      ),
      body: navigationShell,
    );
  }
}

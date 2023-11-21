import 'package:go_router/go_router.dart';
import 'package:tft_guide/ui/pages/items/page.dart';
import 'package:tft_guide/ui/pages/ranked/page.dart';
import 'package:tft_guide/ui/pages/scaffold_navbar.dart';
import 'package:tft_guide/ui/pages/settings/page.dart';

final class GoRouterConfig {
  const GoRouterConfig._();

  static final routes = GoRouter(
    initialLocation: '/ranked',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/ranked',
                builder: (context, state) => const RankedPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/items',
                builder: (context, state) => const ItemsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

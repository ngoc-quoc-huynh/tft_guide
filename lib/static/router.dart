import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/elo_gain/cubit.dart';
import 'package:tft_guide/ui/pages/game/page.dart';
import 'package:tft_guide/ui/pages/item/page.dart';
import 'package:tft_guide/ui/pages/items/page.dart';
import 'package:tft_guide/ui/pages/ranked/page.dart';
import 'package:tft_guide/ui/pages/scaffold_navbar.dart';
import 'package:tft_guide/ui/pages/settings/page.dart';

final class GoRouterConfig {
  const GoRouterConfig._();

  static final _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final routes = GoRouter(
    initialLocation: '/ranked',
    routes: [
      ShellRoute(
        navigatorKey: _rootNavigatorKey,
        builder: (_, __, child) => BlocProvider(
          create: (_) => EloGainCubit(),
          child: child,
        ),
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (_, __, navigationShell) =>
                ScaffoldWithNavBar(navigationShell: navigationShell),
            branches: [
              StatefulShellBranch(
                routes: [
                  ShellRoute(
                    builder: (_, __, child) => child,
                    routes: [
                      GoRoute(
                        name: RankedPage.routeName,
                        path: '/ranked',
                        builder: (_, __) => const RankedPage(),
                        routes: [
                          GoRoute(
                            parentNavigatorKey: _rootNavigatorKey,
                            name: GamePage.routeName,
                            path: 'game',
                            builder: (_, __) => const GamePage(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: ItemsPage.routeName,
                    path: '/items',
                    builder: (_, __) => const ItemsPage(),
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        name: ItemPage.routeName,
                        path: ':id',
                        builder: (_, state) => ItemPage(
                          id: int.parse(state.pathParameters['id']!),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: SettingsPage.routeName,
                    path: '/settings',
                    builder: (_, __) => const SettingsPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

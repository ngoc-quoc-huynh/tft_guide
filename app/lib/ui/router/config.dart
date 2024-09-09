import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/data_sync/bloc.dart';
import 'package:tft_guide/domain/blocs/elo/cubit.dart';
import 'package:tft_guide/domain/blocs/elo_gain/cubit.dart';
import 'package:tft_guide/ui/pages/base_item_detail/page.dart';
import 'package:tft_guide/ui/pages/full_item_detail/page.dart';
import 'package:tft_guide/ui/pages/game/page.dart';
import 'package:tft_guide/ui/pages/init/page.dart';
import 'package:tft_guide/ui/pages/item_metas/page.dart';
import 'package:tft_guide/ui/pages/quotes/page.dart';
import 'package:tft_guide/ui/pages/ranked/page.dart';
import 'package:tft_guide/ui/pages/scaffold_navbar.dart';
import 'package:tft_guide/ui/pages/settings/page.dart';
import 'package:tft_guide/ui/router/routes.dart';

final class GoRouterConfig {
  const GoRouterConfig._();

  static final _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final routes = GoRouter(
    initialLocation: '/ranked',
    routes: [
      ShellRoute(
        navigatorKey: _rootNavigatorKey,
        builder: (_, __, child) => BlocBuilder<DataSyncBloc, DataSyncState>(
          builder: (context, state) => switch (state) {
            DataSyncLoadInProgress() => const InitPage(),
            DataSyncLoadOnSuccess() => MultiBlocProvider(
                providers: [
                  BlocProvider<EloCubit>(
                    create: (_) => EloCubit(),
                  ),
                  BlocProvider<EloGainCubit>(
                    create: (_) => EloGainCubit(),
                  ),
                ],
                child: child,
              ),
          },
        ),
        routes: [
          GoRoute(
            name: Routes.settingsPage(),
            path: '/settings',
            builder: (_, __) => const SettingsPage(),
          ),
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
                        name: Routes.rankedPage(),
                        path: '/ranked',
                        builder: (_, __) => const RankedPage(),
                        routes: [
                          GoRoute(
                            parentNavigatorKey: _rootNavigatorKey,
                            name: Routes.gamePage(),
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
                    name: Routes.itemMetasPage(),
                    path: '/items',
                    builder: (_, __) => const ItemMetasPage(),
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        name: Routes.baseItemsPage(),
                        path: ':id/base',
                        builder: (_, state) => BaseItemDetailPage(
                          id: state.pathParameters['id']!,
                        ),
                      ),
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        name: Routes.fullItemsPage(),
                        path: ':id/full',
                        builder: (_, state) => FullItemDetailPage(
                          id: state.pathParameters['id']!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    name: Routes.quotesPage(),
                    path: '/quotes',
                    builder: (_, __) => const QuotesPage(),
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

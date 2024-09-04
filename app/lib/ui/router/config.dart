import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tft_guide/domain/blocs/data_sync/bloc.dart';
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

// TODO: Refactor
final class GoRouterConfig {
  const GoRouterConfig._();

  static final _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final routes = GoRouter(
    initialLocation: '/ranked',
    routes: [
      GoRoute(
        path: '/',
        name: InitPage.routeName,
        builder: (_, __) => const InitPage(),
      ),
      ShellRoute(
        navigatorKey: _rootNavigatorKey,
        redirect: _handleRedirect,
        builder: (_, __, child) => BlocProvider<EloGainCubit>(
          create: (_) => EloGainCubit(),
          child: child,
        ),
        routes: [
          GoRoute(
            name: SettingsPage.routeName,
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
                    name: ItemMetasPage.routeName,
                    path: '/items',
                    builder: (_, __) => const ItemMetasPage(),
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        name: BaseItemDetailPage.routeName,
                        path: ':id/base',
                        builder: (_, state) => BaseItemDetailPage(
                          id: state.pathParameters['id']!,
                        ),
                      ),
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        name: FullItemDetailPage.routeName,
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
                    name: QuotesPage.routeName,
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

  static String? _handleRedirect(BuildContext context, _) {
    if (context.read<DataSyncBloc>().state is! DataSyncLoadOnSuccess) {
      return '/';
    }
    return null;
  }
}

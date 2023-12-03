import 'package:go_router/go_router.dart';
import 'package:tft_guide/ui/pages/home/page.dart';
import 'package:tft_guide/ui/pages/item/page.dart';

final class GoRouterConfig {
  const GoRouterConfig._();

  static final routes = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: HomePage.routeName,
        path: '/',
        builder: (_, __) => const HomePage(),
        routes: [
          GoRoute(
            name: ItemPage.routeName,
            path: 'items/:id',
            builder: (_, state) => ItemPage(
              id: int.parse(state.pathParameters['id']!),
            ),
          ),
        ],
      ),
    ],
  );
}

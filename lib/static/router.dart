import 'package:go_router/go_router.dart';
import 'package:tft_guide/ui/pages/home/page.dart';

final class GoRouterConfig {
  const GoRouterConfig._();

  static final routes = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: HomePage.routeName,
        path: '/',
        builder: (_, __) => const HomePage(),
      ),
    ],
  );
}

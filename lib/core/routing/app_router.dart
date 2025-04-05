import 'package:docpoint/core/routing/routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final GoRouter router = GoRouter(routes: [
    GoRoute(
      path: Routes.onBoardingScreen,
      builder: (context, state) => OnBoardingScreen(),
    ),
  ]);
}

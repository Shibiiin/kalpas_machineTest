import 'package:go_router/go_router.dart';
import 'package:kalpas/kalpas/presentation/pages/dashBoard_page.dart';
import 'package:kalpas/kalpas/presentation/pages/description_page.dart';
import 'package:kalpas/kalpas/presentation/routes/app_routes.dart';

import '../../data/models/response/apple_article_response_modal.dart';
import '../pages/splash_screen.dart';

class AppPages {
  final GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        builder: (context, state) => DashboardPage(),
      ),
      GoRoute(
        path: AppRoutes.description,
        builder: (context, state) {
          final AppleArticle modal = state.extra as AppleArticle;

          return DescriptionPage(modal: modal);
        },
      )
    ],
  );
}

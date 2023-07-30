import 'package:auto_route/auto_route.dart';
import '../../../view/login/view/login_view.dart';
import '../../../view/splash/view/splash_view.dart';
import '../../../view/onBoard/view/on_board_view.dart';
import '../../../view/home/view/home_view.dart';

part 'navigation_route.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/view'])
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: '/',
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: '/login',
        ),
        AutoRoute(
          page: OnBoardRoute.page,
          path: '/onBoard',
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: '/onBoard',
        )
      ];
}

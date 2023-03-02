import 'package:auto_route/auto_route.dart';
import 'package:flutter_project/features/authentication/presentation/screens/login_screen.dart';
import 'package:flutter_project/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter_project/features/splash/presentation/screens/splash_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: LoginScreen, path: LoginScreen.routeName),
    MaterialRoute(page: DashboardScreen, path: DashboardScreen.routeName),
  ],
)
class $AppRouter {}

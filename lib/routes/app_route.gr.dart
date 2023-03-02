// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../features/authentication/presentation/screens/login_screen.dart'
    as _i2;
import '../features/dashboard/presentation/screens/dashboard_screen.dart'
    as _i3;
import '../features/splash/presentation/screens/splash_screen.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SplashScreen.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashScreen(),
      );
    },
    LoginScreen.name: (routeData) {
      final args = routeData.argsAs<LoginScreenArgs>(
          orElse: () => const LoginScreenArgs());
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.LoginScreen(key: args.key),
      );
    },
    DashboardScreen.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.DashboardScreen(),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          SplashScreen.name,
          path: '/',
        ),
        _i4.RouteConfig(
          LoginScreen.name,
          path: '/loginScreen',
        ),
        _i4.RouteConfig(
          DashboardScreen.name,
          path: 'DashboardScreen',
        ),
      ];
}

/// generated route for
/// [_i1.SplashScreen]
class SplashScreen extends _i4.PageRouteInfo<void> {
  const SplashScreen()
      : super(
          SplashScreen.name,
          path: '/',
        );

  static const String name = 'SplashScreen';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreen extends _i4.PageRouteInfo<LoginScreenArgs> {
  LoginScreen({_i5.Key? key})
      : super(
          LoginScreen.name,
          path: '/loginScreen',
          args: LoginScreenArgs(key: key),
        );

  static const String name = 'LoginScreen';
}

class LoginScreenArgs {
  const LoginScreenArgs({this.key});

  final _i5.Key? key;

  @override
  String toString() {
    return 'LoginScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.DashboardScreen]
class DashboardScreen extends _i4.PageRouteInfo<void> {
  const DashboardScreen()
      : super(
          DashboardScreen.name,
          path: 'DashboardScreen',
        );

  static const String name = 'DashboardScreen';
}

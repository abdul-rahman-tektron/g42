// lib/routes/app_routes.dart
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:smartcards/screens/bottom_bar/bottom_bar_screen.dart';
import 'package:smartcards/screens/custom_screen/network_error_screen.dart';
import 'package:smartcards/screens/custom_screen/not_found_screen.dart';
import 'package:smartcards/screens/dashboard/dashboard_screen.dart';
import 'package:smartcards/screens/login/login_screen.dart';
import 'package:smartcards/screens/scan/scan_screen.dart';
import 'package:smartcards/screens/search/search_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String bottomBar = '/bottom-bar';
  static const String scan = '/scan';
  static const String search = '/search';
  static const String networkError = '/network-error';
  static const String notFound = '/not-found';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

        case AppRoutes.scan:
        return MaterialPageRoute(builder: (_) => const ScanScreen());

        case AppRoutes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

        case AppRoutes.bottomBar:
          final args = settings.arguments as int?;
        return MaterialPageRoute(builder: (_) => BottomBarScreen(currentIndex: args,));

      case AppRoutes.networkError:
        return MaterialPageRoute(builder: (_) => const NetworkErrorScreen());

      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}

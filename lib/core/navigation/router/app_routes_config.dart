import 'package:flutter/material.dart';
import 'package:hungry_app/core/navigation/custom_navigation_bar.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
import 'package:hungry_app/features/auth/view/login_view.dart';
import 'package:hungry_app/features/auth/view/register_view.dart';
import 'package:hungry_app/splash_view.dart';

class AppRoutesConfig {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterPaths.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case AppRouterPaths.signUpScreen:
        return MaterialPageRoute(builder: (_) => const RegisterView());

      case AppRouterPaths.bottomNavigationBar:
        return MaterialPageRoute(builder: (_) => const CustomNavigationBar());

      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  } 
}
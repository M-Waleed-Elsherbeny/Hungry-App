import 'package:flutter/material.dart';
import 'package:hungry_app/core/navigation/custom_navigation_bar.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
import 'package:hungry_app/features/auth/view/login_view.dart';
import 'package:hungry_app/features/auth/view/signup_view.dart';
import 'package:hungry_app/features/checkout/view/checkout_view.dart';
import 'package:hungry_app/features/products/view/product_details_view.dart';
import 'package:hungry_app/splash_view.dart';

class AppRoutesConfig {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterPaths.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case AppRouterPaths.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case AppRouterPaths.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpView());

      case AppRouterPaths.bottomNavigationBar:
        return MaterialPageRoute(builder: (_) => const CustomNavigationBar());

      case AppRouterPaths.productDetails:
        return MaterialPageRoute(builder: (_) => const ProductDetailsView());

      case AppRouterPaths.checkoutScreen:
        return MaterialPageRoute(builder: (_) => const CheckOutView());

      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}

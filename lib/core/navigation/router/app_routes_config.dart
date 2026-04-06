import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/navigation/custom_navigation_bar.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry_app/features/auth/data/repo/auth_repo.dart';
import 'package:hungry_app/features/auth/presentation/view/login_view.dart';
import 'package:hungry_app/features/auth/presentation/view/signup_view.dart';
import 'package:hungry_app/features/cart/data/repo/cart_repo.dart';
import 'package:hungry_app/features/cart/ui/cubit/cart_cubit.dart';
import 'package:hungry_app/features/checkout/view/checkout_view.dart';
import 'package:hungry_app/features/home/data/models/home_product_model.dart';
import 'package:hungry_app/features/products/data/repo/toppings_and_options_repo.dart';
import 'package:hungry_app/features/products/ui/cubit/toppings_and_options_cubit.dart';
import 'package:hungry_app/features/products/ui/view/product_details_view.dart';
import 'package:hungry_app/splash_view.dart';

class AppRoutesConfig {
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterPaths.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case AppRouterPaths.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(AuthRepo()),
            child: const LoginView(),
          ),
        );

      case AppRouterPaths.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(AuthRepo()),
            child: const SignUpView(),
          ),
        );

      case AppRouterPaths.bottomNavigationBar:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(AuthRepo())..getProfileData(),
            child: const CustomNavigationBar(),
          ),
        );

      case AppRouterPaths.productDetails:
        return MaterialPageRoute(
          builder: (_) {
            HomeProductModel product = settings.arguments as HomeProductModel;
            return MultiBlocProvider(
              providers: [
                BlocProvider<ToppingsAndOptionsCubit>(
                  create: (context) =>
                      ToppingsAndOptionsCubit(ToppingsAndOptionsRepo())
                        ..getToppingAndOptions(),
                ),
                BlocProvider<CartCubit>(
                  create: (context) => CartCubit(CartRepo()),
                ),
              ],
              child: ProductDetailsView(productModel: product),
            );
          },
        );

      case AppRouterPaths.checkoutScreen:
        return MaterialPageRoute(builder: (_) => const CheckOutView());

      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: CustomText(
                  text: 'No route defined for ${settings.name}',
                ),
              ),
            );
          },
        );
    }
  }
}

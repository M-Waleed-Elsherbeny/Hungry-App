import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
import 'package:hungry_app/core/navigation/router/app_routes_config.dart';
import 'package:hungry_app/core/services/my_bloc_observer.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Bloc.observer = MyBlocObserver();
  hasToken = await PrefHelper.isUser();
  log("Token: $hasToken");
  userToken = await PrefHelper.getToken();
  log("Token: $userToken");
  runApp(const MyApp());
}

bool hasToken = false;
String? userToken;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hungry App',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.kWhiteColor,
        splashColor: Colors.transparent,
        fontFamily: GoogleFonts.roboto().fontFamily,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.kWhiteColor),
      ),
      initialRoute: AppRouterPaths.splashScreen,
      onGenerateRoute: AppRoutesConfig().onGenerateRoute,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
import 'package:hungry_app/core/navigation/router/app_routes_config.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

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

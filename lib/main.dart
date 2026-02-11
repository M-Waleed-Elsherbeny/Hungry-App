import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/splash_view.dart';

void main() {
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
        fontFamily: GoogleFonts.roboto().fontFamily,
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.kWhiteColor),
      ),
      home: const SplashView(),
    );
  }
}

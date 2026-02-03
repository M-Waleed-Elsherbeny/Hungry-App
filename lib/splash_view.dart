import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/utils/spacer.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Column(
        children: [
          heightSpace(200),
          SvgPicture.asset(AppAssets.logoHungry),
          const Spacer(),
          Image.asset(AppAssets.splashImage),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hungry_app/core/navigation/custom_navigation_bar.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/utils/spacer.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _logoAnimation;
  late Animation<Offset> _imageAnimation;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CustomNavigationBar()),
      );
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, -1), // from top
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _imageAnimation = Tween<Offset>(
      begin: const Offset(0, -0.8),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Column(
        children: [
          heightSpace(200),

          /// Logo Animation
          SlideTransition(
            position: _logoAnimation,
            child: SvgPicture.asset(AppAssets.logoHungry),
          ),

          const Spacer(),

          /// Image Animation
          SlideTransition(
            position: _imageAnimation,
            child: Image.asset(AppAssets.splashImage),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';

class SpicySlider extends StatelessWidget {
  const SpicySlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
  });
  final double value;
  final ValueChanged<double> onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Image.asset(AppAssets.customizeBeefBurger, height: deviceHeight * 0.20),
        const Spacer(),
        Column(
          children: [
            const Text.rich(
              TextSpan(
                text: "Customize ",
                style: AppTextStyle.textBrown16W600,
                children: [
                  TextSpan(
                    text: "Your Burger\n",
                    style: AppTextStyle.textBrown14W400,
                  ),
                  TextSpan(
                    text: "to Your Tastes.\n",
                    style: AppTextStyle.textBrown14W400,
                  ),
                  TextSpan(
                    text: "Ultimate Experience\n\n",
                    style: AppTextStyle.textBrown14W400,
                  ),
                  TextSpan(text: "Spicy", style: AppTextStyle.textBrown16W600),
                ],
              ),
            ),
            Slider(
              min: 0,
              max: 2,
              value: value,
              divisions: 2,
              label: label,
              onChanged: onChanged,
              activeColor: AppColors.kPrimaryColor,
              inactiveColor: AppColors.kGreyColor,
            ),
            Row(
              children: [
                const Text("🥶"),
                widthSpace(deviceWidth * 0.4),
                const Text("🌶"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

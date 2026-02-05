import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';

class CustomCartButton extends StatelessWidget {
  const CustomCartButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.kPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        alignment: Alignment.center,
        elevation: 10,
        minimumSize: Size(deviceWidth * 0.35, deviceHeight * 0.05),
        // minimumSize: const Size(150, 50),
      ),
      child: const Text("Remove", style: AppTextStyle.textWhite16W500),
    );
  }
}

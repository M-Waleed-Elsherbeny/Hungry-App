import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.title,
    this.onTap,
    this.buttonColor,
    this.textStyle,
  });
  final String title;
  final VoidCallback? onTap;
  final Color? buttonColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? AppColors.kWhiteColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.kWhiteColor),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        elevation: 10,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(title, style: textStyle ?? AppTextStyle.textGreen20WBold),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onTap,
    this.minimumSize,
    this.backgroundColor,
    this.textStyle,
  });
  final String title;
  final VoidCallback? onTap;
  final Size? minimumSize;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: AppColors.kPrimaryColor),
        ),
        alignment: Alignment.center,
        elevation: 10,
        minimumSize: minimumSize ?? const Size(150, 50),
      ),
      child: CustomText(
        text: title,
        textStyle: textStyle ?? AppTextStyle.textWhite16W500,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.title,
    this.onTap,
    this.minimumSize,
    this.backgroundColor = AppColors.kPrimaryColor,
    this.borderColor,
    this.textStyle,
    this.child,
  });
  final String? title;
  final VoidCallback? onTap;
  final Size? minimumSize;
  final Color? backgroundColor, borderColor;
  final TextStyle? textStyle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: borderColor ?? AppColors.kWhiteColor,
            width: borderColor != null ? 2 : 0,
          ),
        ),
        alignment: Alignment.center,
        elevation: 10,
        minimumSize: minimumSize ?? const Size(150, 50),
      ),
      child:
          child ??
          CustomText(
            text: title ?? "Add Title",
            textStyle: textStyle ?? AppTextStyle.textWhite16W500,
          ),
    );
  }
}

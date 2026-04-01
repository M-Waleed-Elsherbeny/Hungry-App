import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';

class CustomProfileTextField extends StatelessWidget {
  const CustomProfileTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.isPassword = false,
    this.style,
    this.labelStyle, this.borderColor,
  });
  final String labelText;
  final TextEditingController controller;
  final bool isPassword;
  final TextStyle? style, labelStyle;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        cursorColor: AppColors.kWhiteColor,
        style: style ?? AppTextStyle.textWhite14W400,
        cursorHeight: 20,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelStyle ?? AppTextStyle.textWhite16W500,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: borderColor ?? Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: borderColor ?? Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: borderColor ?? Colors.white),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: AppColors.kRedColor),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: borderColor ?? Colors.white),
          ),
        ),
      ),
    );
  }
}

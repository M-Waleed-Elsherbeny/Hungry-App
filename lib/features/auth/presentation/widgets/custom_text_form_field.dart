import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconColor,
    this.suffixIconColor,
    this.isPassword = false,
    this.onTapSuffixIcon,
    this.controller, required this.fieldName,
  });
  final String hintText, fieldName;
  final IconData? prefixIcon, suffixIcon;
  final Color? prefixIconColor, suffixIconColor;
  final bool isPassword;
  final VoidCallback? onTapSuffixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.kPrimaryColor,
      cursorErrorColor: AppColors.kRedColor,
      cursorWidth: 4.0,
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$fieldName is required';
        }
        return null;
      },
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscureText: isPassword,

      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.kWhiteColor,
        prefixIcon: Icon(
          prefixIcon,
          color: prefixIconColor ?? AppColors.kPrimaryColor,
        ),
        suffixIcon: IconButton(
          onPressed: onTapSuffixIcon,
          icon: Icon(
            suffixIcon,
            color: suffixIconColor ?? AppColors.kPrimaryColor,
          ),
        ),
        hintText: hintText,
        hintStyle: AppTextStyle.textBrown14W400,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.kWhiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.kWhiteColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.kRedColor, width: 2),
        ),
        errorStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.kRedColor,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.kRedColor, width: 2),
        ),
      ),
    );
  }
}

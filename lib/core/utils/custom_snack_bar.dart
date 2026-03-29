import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';

customSnackBar(
  BuildContext context,
  String message, {
  bool isErrorMessage = true,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.only(bottom: 30, right: 15, left: 15),
      behavior: SnackBarBehavior.floating,
      elevation: 20,
      clipBehavior: Clip.none,
      backgroundColor: isErrorMessage
          ? AppColors.kRedColor
          : AppColors.kPrimaryColor.withAlpha(200),
      content: Row(
        children: [
          Icon(
            isErrorMessage
                ? CupertinoIcons.info_circle
                : CupertinoIcons.checkmark_seal,
            color: AppColors.kLightWhiteColor,
          ),
          widthSpace(10),
          CustomText(text: message, textStyle: AppTextStyle.textWhite16W500),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';

IconButton customBackButton(BuildContext context) {
  return IconButton(
    onPressed: () => Navigator.pop(context),
    style: IconButton.styleFrom(backgroundColor: AppColors.kPrimaryColor),
    icon: const Icon(
      Icons.arrow_back_ios_new_rounded,
      color: Colors.white,
      size: 20,
    ),
  );
}

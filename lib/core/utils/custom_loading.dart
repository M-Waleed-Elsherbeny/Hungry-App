import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';

Widget customLoading({Color? color}) {
  return Center(
    child: CircularProgressIndicator(color: color ?? AppColors.kWhiteColor),
  );
}

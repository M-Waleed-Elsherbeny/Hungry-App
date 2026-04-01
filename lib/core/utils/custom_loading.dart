import 'package:flutter/cupertino.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';

Widget customLoading({Color? color}) {
  return Center(
    child: CupertinoActivityIndicator(color: color ?? AppColors.kWhiteColor),
  );
}

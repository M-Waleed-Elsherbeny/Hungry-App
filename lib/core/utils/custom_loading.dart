import 'package:flutter/cupertino.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';

Widget customLoading({Color? color = AppColors.kWhiteColor}) {
  return SizedBox(
    width: 50,
    height: 50,
    child: Center(child: CupertinoActivityIndicator(color: color)),
  );
}

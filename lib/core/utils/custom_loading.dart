import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';

Widget customLoading({Color? color = AppColors.kWhiteColor}) {
  return SizedBox(
    width: 50.w,
    height: 50.h,
    child: Center(child: CupertinoActivityIndicator(color: color)),
  );
}

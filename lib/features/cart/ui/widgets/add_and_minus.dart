import 'package:flutter/cupertino.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';

class AddAndMinus extends StatelessWidget {
  const AddAndMinus({super.key, this.icon, this.onPressed});
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: deviceWidth * 0.1,
        height: deviceHeight * 0.05,
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.kWhiteColor),
      ),
    );
  }
}

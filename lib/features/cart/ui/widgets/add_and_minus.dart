import 'package:flutter/cupertino.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';

class AddAndMinus extends StatelessWidget {
  const AddAndMinus({
    super.key,
    this.icon,
    this.onTapAddButton,
    this.onTapMinusButton,
    required this.quantity,
  });
  final IconData? icon;
  final VoidCallback? onTapAddButton, onTapMinusButton;
  final int? quantity;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        GestureDetector(
          onTap: onTapMinusButton,
          child: Container(
            height: deviceHeight * 0.04,
            width: deviceHeight * 0.04,
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              CupertinoIcons.minus,
              color: AppColors.kWhiteColor,
            ),
          ),
        ),
        widthSpace(deviceWidth * 0.05),
        CustomText(
          text: quantity.toString(),
          textStyle: AppTextStyle.textBrown16W600,
        ),
        widthSpace(deviceWidth * 0.05),
        GestureDetector(
          onTap: onTapAddButton,
          child: Container(
            height: deviceHeight * 0.04,
            width: deviceHeight * 0.04,
            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              CupertinoIcons.plus,
              color: AppColors.kWhiteColor,
            ),
          ),
        ),
      ],
    );
  }
}

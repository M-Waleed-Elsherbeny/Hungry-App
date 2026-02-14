import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_button.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';

class CustomTotalWithButton extends StatelessWidget {
  const CustomTotalWithButton({
    super.key,
    required this.totalPrice,
    required this.buttonTitle,
    required this.onTap,
  });
  final String totalPrice, buttonTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: deviceHeight * 0.1,
      decoration: const BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.kPrimaryColor,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: deviceHeight * 0.01,
        horizontal: deviceWidth * 0.05,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total", style: AppTextStyle.textBrown16W600),
              heightSpace(deviceHeight * 0.01),
              Text("\$ $totalPrice", style: AppTextStyle.textGreen20WBold),
            ],
          ),
          const Spacer(),
          CustomButton(title: buttonTitle, onTap: onTap),
          heightSpace(deviceHeight * 0.1),
        ],
      ),
    );
  }
}

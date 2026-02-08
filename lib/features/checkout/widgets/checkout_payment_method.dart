import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';

class CheckoutPaymentMethod extends StatelessWidget {
  const CheckoutPaymentMethod({
    super.key,
    required this.paymentMethod,
    required this.paymentImage,
    required this.radioValue,
    this.tileColor,
    this.isVisa = false,
    required this.radioGroupValue,
    required this.onChanged,
    this.onTap,
  });
  final String paymentMethod, paymentImage, radioValue, radioGroupValue;
  final Color? tileColor;
  final bool isVisa;
  final ValueChanged<String?> onChanged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 0.02,
        vertical: isVisa ? deviceHeight * 0.001 : deviceHeight * 0.01,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: tileColor ?? AppColors.kBrownColor,
      title: Text(
        paymentMethod,
        style: isVisa
            ? AppTextStyle.textBrown16W600
            : AppTextStyle.textWhite16W500,
      ),
      subtitle: isVisa
          ? const Text(
              "3566 **** **** 1234",
              style: AppTextStyle.textBrown14W400,
            )
          : null,
      leading: Image.asset(paymentImage, width: deviceWidth * 0.15),
      trailing: RadioGroup(
        groupValue: radioGroupValue,
        onChanged: onChanged,
        child: Radio(value: radioValue, activeColor: AppColors.kWhiteColor),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/cart/widgets/add_and_minus.dart';
import 'package:hungry_app/features/cart/widgets/custom_cart_button.dart';

class CustomCartCard extends StatelessWidget {
  const CustomCartCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.quantity,
    required this.onTapAddButton,
    required this.onTapMinusButton,
    required this.onTapRemoveButton,
  });

  final String image, title, description;
  final int quantity;
  final VoidCallback onTapAddButton, onTapMinusButton, onTapRemoveButton;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.only(
        top: deviceHeight * 0.02,
        bottom: deviceHeight * 0.02,
      ),
      color: AppColors.kWhiteColor,
      elevation: 10,
      shadowColor: AppColors.kPrimaryColor,
      child: Padding(
        padding: EdgeInsets.only(
          right: deviceWidth * 0.02,
          left: deviceWidth * 0.02,
        ),
        child: Row(
          children: [
            SizedBox(
              width: deviceWidth * 0.5,
              height: deviceHeight * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(image, width: deviceWidth * 0.3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: title,
                        textStyle: AppTextStyle.textBrown16W600,
                      ),
                      CustomText(
                        text: description,
                        textStyle: AppTextStyle.textBrown14W400,
                      ),
                      heightSpace(deviceHeight * 0.01),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    AddAndMinus(
                      icon: CupertinoIcons.minus,
                      onPressed: onTapMinusButton,
                    ),
                    widthSpace(deviceWidth * 0.05),
                    CustomText(
                      text: quantity.toString(),
                      textStyle: AppTextStyle.textBrown16W600,
                    ),
                    widthSpace(deviceWidth * 0.05),
                    AddAndMinus(
                      icon: CupertinoIcons.plus,
                      onPressed: onTapAddButton,
                    ),
                  ],
                ),
                heightSpace(deviceHeight * 0.02),
                CustomCartButton(onPressed: onTapRemoveButton),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

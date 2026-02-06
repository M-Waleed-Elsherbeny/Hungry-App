import 'package:flutter/cupertino.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/cart/widgets/add_and_minus.dart';
import 'package:hungry_app/features/cart/widgets/custom_cart_button.dart';

class CustomAddRemoveButtons extends StatelessWidget {
  const CustomAddRemoveButtons({
    super.key,
    required this.onTopRemoveButton,
    required this.onTapAddButton,
    required this.onTapMinusButton,
    required this.increaseValue, this.index,
  });
  final VoidCallback onTopRemoveButton, onTapAddButton, onTapMinusButton;
  final int increaseValue;
  final int? index;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(right: deviceWidth * 0.03),
      child: Column(
        children: [
          Row(
            children: [
              AddAndMinus(
                icon: CupertinoIcons.minus,
                onPressed: onTapMinusButton,
              ),
              widthSpace(deviceWidth * 0.05),
              Text("$increaseValue", style: AppTextStyle.textBrown16W600),
              widthSpace(deviceWidth * 0.05),
              AddAndMinus(icon: CupertinoIcons.plus, onPressed: onTapAddButton),
            ],
          ),
          heightSpace(deviceHeight * 0.02),
          CustomCartButton(onPressed: onTopRemoveButton),
        ],
      ),
    );
  }
}

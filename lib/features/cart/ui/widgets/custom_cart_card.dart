import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/custom_loading.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/cart/ui/widgets/add_and_minus.dart';
import 'package:hungry_app/features/cart/ui/widgets/custom_cart_button.dart';
import 'package:hungry_app/features/products/data/models/toppings_and_options_model.dart';

class CustomCartCard extends StatelessWidget {
  const CustomCartCard({
    super.key,
    required this.burgerImage,
    required this.title,
    required this.toppingsList,
    required this.quantity,
    required this.onTapAddButton,
    required this.onTapMinusButton,
    required this.onTapRemoveButton,
    required this.optionList,
    this.isLoading = false,
  });

  final String burgerImage, title;
  final int quantity;
  final List<ToppingsAndOptionsModel?> toppingsList, optionList;
  final VoidCallback onTapAddButton, onTapMinusButton;
  final VoidCallback? onTapRemoveButton;
  final bool isLoading;

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
          right: deviceWidth * 0.03,
          left: deviceWidth * 0.03,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(burgerImage, width: deviceWidth * 0.3),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: deviceWidth * 0.45,
                      height: deviceHeight * 0.05,
                      child: CustomText(
                        maxLines: 2,
                        text: title,
                        textStyle: AppTextStyle.textBrown16W600,
                      ),
                    ),
                    heightSpace(deviceHeight * 0.01),
                    SizedBox(
                      width: deviceWidth * 0.4,
                      child: Row(
                        children: [
                          Row(
                            children: List.generate(toppingsList.length, (
                              index,
                            ) {
                              return Container(
                                height: deviceHeight * 0.03,
                                margin: EdgeInsets.only(
                                  right: deviceHeight * 0.003,
                                ),
                                // decoration: const BoxDecoration(
                                //   color: Colors.red,
                                // ),
                                child: Image.network(
                                  toppingsList[index]?.image ?? "",
                                  width: deviceWidth * 0.05,
                                ),
                              );
                            }),
                          ),
                          Row(
                            children: List.generate(optionList.length, (index) {
                              return Container(
                                height: deviceHeight * 0.03,
                                margin: EdgeInsets.only(
                                  right: deviceHeight * 0.003,
                                ),
                                // decoration: const BoxDecoration(
                                //   color: Colors.red,
                                // ),
                                child: Image.network(
                                  optionList[index]?.image ?? "",
                                  width: deviceWidth * 0.05,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    heightSpace(deviceHeight * 0.01),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                AddAndMinus(
                  icon: CupertinoIcons.minus,
                  onTapMinusButton: onTapMinusButton,
                  onTapAddButton: onTapAddButton,
                  quantity: quantity,
                ),
                heightSpace(deviceHeight * 0.02),
                isLoading
                    ? customLoading(color: AppColors.kPrimaryColor)
                    : CustomCartButton(onPressed: onTapRemoveButton),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

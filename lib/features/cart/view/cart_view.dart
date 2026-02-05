import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              margin: EdgeInsets.symmetric(vertical: deviceHeight * 0.05),
              // surfaceTintColor: AppColors.kWhiteColor,
              color: AppColors.kWhiteColor,
              elevation: 10,
              shadowColor: AppColors.kPrimaryColor,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppAssets.mushroomBurger,
                        width: deviceWidth * 0.3,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.05,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Mushroom Burger",
                              style: AppTextStyle.textBrown16W600,
                            ),
                            const Text(
                              "Veggie Burger",
                              style: AppTextStyle.textBrown14W400,
                            ),
                            heightSpace(deviceHeight * 0.01),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Column(children: []),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

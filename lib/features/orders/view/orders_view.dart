import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_button.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: deviceHeight * 0.1),
        itemCount: 3,
        itemBuilder: (_, index) {
          return Card(
            margin: EdgeInsets.only(
              top: deviceHeight * 0.02,
              bottom: deviceHeight * 0.02,
            ),
            color: AppColors.kWhiteColor,
            elevation: 10,
            shadowColor: AppColors.kPrimaryColor,
            child: Padding(
              padding: EdgeInsets.all(deviceWidth * 0.04),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        AppAssets.friedChickenBurger,
                        width: deviceWidth * 0.4,
                      ),
                      SizedBox(
                        width: deviceWidth * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomText(
                              text: "Fried Chicken Burger",
                              textStyle: AppTextStyle.textBrown16W600,
                            ),
                            const CustomText(
                              text: "Qty: 3",
                              textStyle: AppTextStyle.textBrown14W400,
                            ),
                            const CustomText(
                              text: "Price: 20\$",
                              textStyle: AppTextStyle.textBrown14W400,
                            ),
                            heightSpace(deviceHeight * 0.015),
                          ],
                        ),
                      ),
                    ],
                  ),
                  heightSpace(deviceHeight * 0.015),
                  CustomButton(
                    minimumSize: Size(double.infinity, deviceHeight * 0.05),
                    title: "Order Again",
                    onTap: () {},
                  ),
                  heightSpace(deviceHeight * 0.015),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';

class CardDetailsView extends StatelessWidget {
  const CardDetailsView({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.rate,
    required this.price,
  });
  final String image, title, subtitle, rate, price;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Card(
      elevation: 10,
      shadowColor: AppColors.kPrimaryColor,
      color: AppColors.kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: deviceWidth,
                child: Image.network(image, height: deviceHeight * 0.12),
              ),
              Positioned(
                top: 5,
                right: 10,
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    CupertinoIcons.heart,
                    color: AppColors.kRedColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceHeight * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  textStyle: AppTextStyle.textBrown16W600,
                ),
                CustomText(
                  text: subtitle,
                  textStyle: AppTextStyle.textBrown16W400,
                ),
                heightSpace(deviceHeight * 0.015),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        CupertinoIcons.star_fill,
                        color: Colors.amber,
                        size: 20,
                      ),
                    ),
                    widthSpace(deviceWidth * 0.01),
                    CustomText(
                      text: rate,
                      textStyle: AppTextStyle.textBrown14W400,
                    ),
                    const Spacer(),
                    CustomText(
                      text: "\$ $price",
                      textStyle: AppTextStyle.textGreen20WBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
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
  });
  final String image, title, subtitle, rate;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Card(
      elevation: 10,
      shadowColor: AppColors.kPrimaryColor,
      color: AppColors.kWhiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(image, width: deviceWidth * 0.25),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(AppAssets.shadow),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyle.textBrown16W600),
                Text(subtitle, style: AppTextStyle.textBrown16W400),
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
                    Text(rate, style: AppTextStyle.textBrown14W400),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        CupertinoIcons.heart_fill,
                        color: AppColors.kRedColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

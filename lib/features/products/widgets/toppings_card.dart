import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';

class ToppingsCard extends StatelessWidget {
  const ToppingsCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });
  final String image, title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Stack(
          children: [
            Container(
              width: deviceWidth * 0.25,
              height: deviceHeight * 0.15,
              decoration: BoxDecoration(
                color: AppColors.kWhiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: deviceWidth * 0.25,
                height: deviceHeight * 0.15,
                decoration: BoxDecoration(
                  color: AppColors.kBrownColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceWidth * 0.02,
                    vertical: deviceHeight * 0.01,
                  ),
                  child: Row(
                    children: [
                      Text(title, style: AppTextStyle.textWhite14W400),
                      const Spacer(),
                      InkWell(
                        onTap: onTap,
                        child: CircleAvatar(
                          radius: deviceHeight * 0.015,
                          backgroundColor: AppColors.kRedColor,
                          child: const Icon(
                            Icons.add_outlined,
                            color: AppColors.kWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                width: deviceWidth * 0.25,
                height: deviceHeight * 0.1,
                decoration: BoxDecoration(
                  color: AppColors.kWhiteColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

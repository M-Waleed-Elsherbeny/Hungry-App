import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';

class CustomCartImageWithDesc extends StatelessWidget {
  const CustomCartImageWithDesc({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });
  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(image, width: deviceWidth * 0.3),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyle.textBrown16W600),
              Text(description, style: AppTextStyle.textBrown14W400),
              heightSpace(deviceHeight * 0.01),
            ],
          ),
        ),
      ],
    );
  }
}

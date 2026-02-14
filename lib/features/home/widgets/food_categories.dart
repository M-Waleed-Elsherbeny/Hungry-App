import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';

class FoodCategories extends StatefulWidget {
  const FoodCategories({super.key});

  @override
  State<FoodCategories> createState() => _FoodCategoriesState();
}

class _FoodCategoriesState extends State<FoodCategories> {
  List<String> categories = ["All", "Combos", "Sliders", "Classic", "Special"];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(categories.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                currentIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: deviceWidth * 0.02),
              padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.05,
                vertical: deviceHeight * 0.01,
              ),
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? AppColors.kPrimaryColor
                    : AppColors.kLightWhiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: CustomText(
                text: categories[index],
                textStyle: currentIndex == index
                    ? AppTextStyle.textWhite16W500
                    : AppTextStyle.textGrey18W500.copyWith(fontSize: 16),
              ),
            ),
          );
        }),
      ),
    );
  }
}

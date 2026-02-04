import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';

class SearchBarView extends StatelessWidget {
  const SearchBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: AppColors.kWhiteColor,
      shadowColor: AppColors.kPrimaryColor,
      child: TextField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        cursorColor: AppColors.kPrimaryColor,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: AppColors.kBrownColor),
          hintText: "Search",
          hintStyle: AppTextStyle.textBrown16W400,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.kWhiteColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.kWhiteColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.kPrimaryColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

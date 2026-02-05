import 'package:flutter/material.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/home/widgets/card_grid_view.dart';
import 'package:hungry_app/features/home/widgets/food_categories.dart';
import 'package:hungry_app/features/home/widgets/search_bar_view.dart';
import 'package:hungry_app/features/home/widgets/user_header.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              heightSpace(deviceHeight * 0.03),
              // Header Section
              const UserHeader(),
              heightSpace(deviceHeight * 0.03),
              // Search Bar
              const SearchBarView(),
              heightSpace(deviceHeight * 0.03),
              // Categories
              const FoodCategories(),
              heightSpace(deviceHeight * 0.03),
              // Food Items
              const CardGridView(),
            ],
          ),
        ),
      ),
    );
  }
}

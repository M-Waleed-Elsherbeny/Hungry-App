import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/features/home/widgets/card_details_view.dart';

class CardGridView extends StatelessWidget {
  const CardGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemCount: 10,
      itemBuilder: (_, index) {
        return const CardDetailsView(
          image: AppAssets.cheeseBeefBurger,
          title: "Cheese Beef Burger",
          subtitle: "Wendy's Burger",
          rate: "4.5",
        );
      },
    );
  }
}

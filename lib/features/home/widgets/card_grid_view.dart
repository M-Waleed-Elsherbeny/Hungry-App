import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/features/home/widgets/card_details_view.dart';
import 'package:hungry_app/features/products/view/product_details_view.dart';

class CardGridView extends StatelessWidget {
  const CardGridView({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: deviceWidth * 0.02,
        mainAxisSpacing: deviceHeight * 0.02,
        childAspectRatio: deviceWidth / (deviceHeight * 0.55),
      ),
      itemCount: 10,
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProductDetailsView()),
            );
          },
          child: const CardDetailsView(
            image: AppAssets.cheeseBeefBurger,
            title: "Cheese Beef Burger",
            subtitle: "Wendy's Burger",
            rate: "4.5",
          ),
        );
      },
    );
  }
}

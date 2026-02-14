import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_back_button.dart';
import 'package:hungry_app/core/components/custom_total_with_button.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/products/widgets/spicy_slider.dart';
import 'package:hungry_app/features/products/widgets/toppings_card.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double currentValue = 0;
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(leading: customBackButton(context)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpicySlider(
                value: currentValue,
                label: currentValue == 0.0
                    ? "Not Spicy"
                    : currentValue == 1.0
                    ? "Spicy"
                    : "Very Spicy",
                onChanged: (value) {
                  setState(() {
                    currentValue = value;
                  });
                },
              ),

              heightSpace(deviceHeight * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Toppings", style: AppTextStyle.textBrown16W600),
                    heightSpace(deviceHeight * 0.02),
                    SingleChildScrollView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(6, (index) {
                          return Padding(
                            padding: EdgeInsets.only(right: deviceWidth * 0.02),
                            child: ToppingsCard(
                              image: AppAssets.tomato,
                              title: "Tomato",
                              onTap: () {},
                            ),
                          );
                        }),
                      ),
                    ),
                    heightSpace(deviceHeight * 0.02),
                    const Text(
                      "Side Options",
                      style: AppTextStyle.textBrown16W600,
                    ),
                    heightSpace(deviceHeight * 0.02),
                    SingleChildScrollView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(6, (index) {
                          return Padding(
                            padding: EdgeInsets.only(right: deviceWidth * 0.02),
                            child: ToppingsCard(
                              image: AppAssets.coleslaw,
                              title: "Coleslaw",
                              onTap: () {},
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              heightSpace(deviceHeight * 0.01),

              // Total Section
            ],
          ),
        ),
      ),
      // Total Section
      bottomSheet: CustomTotalWithButton(
        totalPrice: "18.99",
        buttonTitle: "Add to Cart",
        onTap: () {},
      ),
    );
  }
}

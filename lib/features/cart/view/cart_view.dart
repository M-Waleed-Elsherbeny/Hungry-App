import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_button.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/cart/widgets/custom_add_remove_buttons.dart';
import 'package:hungry_app/features/cart/widgets/custom_cart_image_with_desc.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int initialTotal = 1;
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: deviceHeight * 0.1),
          itemCount: 4,
          itemBuilder: (_, index) {
            return Card(
              margin: EdgeInsets.only(
                top: deviceHeight * 0.02,
                bottom: deviceHeight * 0.02,
              ),
              color: AppColors.kWhiteColor,
              elevation: 10,
              shadowColor: AppColors.kPrimaryColor,
              child: Row(
                children: [
                  const CustomCartImageWithDesc(
                    image: AppAssets.mushroomBurger,
                    title: "Mushroom Burger",
                    description: "Veggie Burger",
                  ),
                  const Spacer(),
                  CustomAddRemoveButtons(
                    onTopRemoveButton: () {},
                    onTapAddButton: () {
                      setState(() {
                        initialTotal++;
                      });
                    },
                    onTapMinusButton: () {
                      if (initialTotal > 1) {
                        initialTotal--;
                        setState(() {});
                      }
                    },
                    increaseValue: initialTotal,
                  ),
                ],
              ),
            );
          },
        ),
      ),
      // Total Section
      bottomSheet: Container(
        width: double.infinity,
        height: deviceHeight * 0.1,
        color: AppColors.kWhiteColor,
        padding: EdgeInsets.symmetric(
          vertical: deviceHeight * 0.01,
          horizontal: deviceWidth * 0.05,
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total", style: AppTextStyle.textBrown16W600),
                heightSpace(deviceHeight * 0.01),
                const Text("\$ 18.99", style: AppTextStyle.textGreen20WBold),
              ],
            ),
            const Spacer(),
            CustomButton(title: "Checkout", onTap: () {}),
            heightSpace(deviceHeight * 0.1),
          ],
        ),
      ),
    );
  }
}

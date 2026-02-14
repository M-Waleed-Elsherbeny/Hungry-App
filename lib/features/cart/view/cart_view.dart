import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_total_with_button.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/features/cart/widgets/custom_cart_card.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List<int> qty;
  @override
  void initState() {
    qty = List.generate(15, (_) => 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.kWhiteColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: deviceHeight * 0.1),
          itemCount: qty.length,
          itemBuilder: (_, index) {
            return CustomCartCard(
              image: AppAssets.cheeseBeefBurger,
              title: "Cheese Beef Burger",
              description: "Wendy's Burger",
              quantity: qty[index],
              onTapAddButton: () {
                setState(() {
                  qty[index]++;
                });
              },
              onTapMinusButton: () {
                if (qty[index] > 1) {
                  setState(() {
                    qty[index]--;
                  });
                }
              },
              onTapRemoveButton: () {},
            );
          },
        ),
      ),
      // Total Section
      bottomSheet: CustomTotalWithButton(
        totalPrice: "18.99",
        buttonTitle: "Checkout",
        onTap: () {
          Navigator.pushNamed(context, AppRouterPaths.checkoutScreen);
        },
      ),
    );
  }
}

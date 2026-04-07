import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/components/custom_total_with_button.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/features/cart/ui/cubit/cart_cubit.dart';
import 'package:hungry_app/features/cart/ui/cubit/cart_state.dart';
import 'package:hungry_app/features/cart/ui/widgets/custom_cart_card.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List<int> qty;
  @override
  void initState() {
    context.read<CartCubit>().getUserCart();
    qty = List.generate(15, (_) => 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.kWhiteColor,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
            child: state is GetUserCartSuccess && state.cartModel != null
                ? ListView.builder(
                    padding: EdgeInsets.only(bottom: deviceHeight * 0.1),
                    itemCount: qty.length,
                    itemBuilder: (_, index) {
                      final cartModel = state.cartModel;
                      final userCart = cartModel!.items[index];
                      return CustomCartCard(
                        image: AppAssets.cheeseBeefBurger,
                        title: userCart.name,
                        description: "Wendy's Burger",
                        quantity: userCart.quantity,
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
                  )
                : const Center(
                    child: CustomText(
                      text: "Your Cart is Empty",
                      textStyle: AppTextStyle.textBrown18W700,
                    ),
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
      },
    );
  }
}

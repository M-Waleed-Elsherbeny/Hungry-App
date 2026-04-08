import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/components/custom_total_with_button.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/utils/custom_snack_bar.dart';
import 'package:hungry_app/features/cart/data/models/user_cart_model.dart';
import 'package:hungry_app/features/cart/ui/cubit/cart_cubit.dart';
import 'package:hungry_app/features/cart/ui/cubit/cart_state.dart';
import 'package:hungry_app/features/cart/ui/widgets/custom_cart_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  UserCartModel? userCart;
  int currentQty = 1;
  @override
  void initState() {
    context.read<CartCubit>().getUserCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is GetUserCartFailure) {
          customSnackBar(context, state.errMsg);
        } else if (state is GetUserCartSuccess &&
            state.cartModel!.items.isNotEmpty) {
          userCart = state.cartModel;
          setState(() {});
        }
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
            child: Skeletonizer(
              enabled:
                  state is GetUserCartLoading ||
                  state is CartInitial ||
                  userCart == null,
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: deviceHeight * 0.1),
                itemBuilder: (_, index) {
                  var cartItems = userCart?.items[index];
                  final userQty = userCart?.items[index].quantity ?? 1;
                  log("userQty : $userQty");
                  log("currentQty : $currentQty");
                  return CustomCartCard(
                    image: cartItems?.image ?? "",
                    title: cartItems?.name ?? "",
                    description: "Wendy's Burger",
                    quantity: (currentQty > userQty) ? currentQty : userQty,
                    onTapAddButton: () {
                      currentQty++;
                      setState(() {});
                    },
                    onTapMinusButton: () {
                      if (currentQty > 1) {
                        setState(() {
                          currentQty--;
                        });
                      }
                    },
                    onTapRemoveButton: () {},
                  );
                },
                itemCount: userCart?.items.length ?? 0,
              ),
            ),
          ),
          // Total Section
          bottomSheet: Skeletonizer(
            enabled: state is GetUserCartLoading || state is CartInitial,
            child: CustomTotalWithButton(
              totalPrice: userCart?.totalPrice ?? 0.0.toString(),
              buttonTitle: "Checkout",
              onTap: () {
                Navigator.pushNamed(context, AppRouterPaths.checkoutScreen);
              },
            ),
          ),
        );
      },
    );
  }
}

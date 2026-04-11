import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/components/custom_total_with_button.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/custom_snack_bar.dart';
import 'package:hungry_app/features/cart/data/models/user_cart_model.dart';
import 'package:hungry_app/features/cart/ui/cubit/cart_cubit.dart';
import 'package:hungry_app/features/cart/ui/cubit/cart_state.dart';
import 'package:hungry_app/features/cart/ui/widgets/custom_cart_card.dart';
import 'package:hungry_app/features/products/data/models/toppings_and_options_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  UserCartModel? userCart;
  List<ToppingsAndOptionsModel?> toppings = [];
  List<ToppingsAndOptionsModel?> options = [];
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
      buildWhen: (previous, current) {
        return current is GetUserCartSuccess || userCart == null;
      },
      listener: (context, state) {
        // if (state is GetUserCartFailure) {
        //   customSnackBar(context, state.errMsg);
        // }
        if (state is GetUserCartSuccess && state.cartModel!.items.isNotEmpty) {
          userCart = state.cartModel;
        }
        if (state is DeleteFromCartSuccess) {
          customSnackBar(
            context,
            "Deleted From Cart Successfully..",
            isErrorMessage: false,
          );
        }
        if (state is DeleteFromCartFailure) {
          customSnackBar(context, state.errMsg);
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
                  state is GetUserCartLoading || state is DeleteFromCartLoading,
              child:
                  state is GetUserCartSuccess &&
                      (userCart != null && userCart!.items.isNotEmpty)
                  ? ListView.builder(
                      padding: EdgeInsets.only(bottom: deviceHeight * 0.1),
                      itemBuilder: (_, index) {
                        var cartItems = userCart!.items[index];
                        toppings = cartItems!.toppings;
                        options = cartItems.sideOptions;
                        final userQty = userCart!.items[index]?.quantity ?? 1;
                        return Column(
                          children: [
                            CustomCartCard(
                              burgerImage: cartItems.image,
                              title: cartItems.name,
                              toppingsList: toppings,
                              optionList: options,
                              quantity: userQty,
                              onTapAddButton: () {
                                // currentQty++;
                                // setState(() {});
                              },
                              onTapMinusButton: () {
                                // if (currentQty > 1) {
                                //   setState(() {
                                //     currentQty--;
                                //   });
                                // }
                              },
                              isLoading: state is DeleteFromCartLoading,
                              onTapRemoveButton: state is DeleteFromCartLoading
                                  ? null
                                  : () async {
                                      final id = cartItems.itemId;
                                      await context
                                          .read<CartCubit>()
                                          .deleteFromCart(id: id);
                                    },
                            ),
                          ],
                        );
                      },
                      itemCount: userCart?.items.length ?? 0,
                    )
                  : const Center(
                      child: CustomText(
                        text: "Your Cart is Empty...",
                        textStyle: AppTextStyle.textBrown18W700,
                      ),
                    ),
            ),
          ),
          // Total Section
          bottomSheet: Skeletonizer(
            enabled: state is GetUserCartLoading || state is CartInitial,
            child: CustomTotalWithButton(
              totalPrice: userCart?.totalPrice ?? 0.0.toString(),
              buttonTitle: "Checkout",
              onTap: userCart == null ? null : () {
                Navigator.pushNamed(context, AppRouterPaths.checkoutScreen, arguments: userCart);
              },
            ),
          ),
        );
      },
    );
  }
}

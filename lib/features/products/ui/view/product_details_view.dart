import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/components/custom_back_button.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/components/custom_total_with_button.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/custom_snack_bar.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/cart/data/models/cart_model.dart';
import 'package:hungry_app/features/cart/ui/cubit/cart_cubit.dart';
import 'package:hungry_app/features/cart/ui/cubit/cart_state.dart';
import 'package:hungry_app/features/home/data/models/home_product_model.dart';
import 'package:hungry_app/features/products/data/models/toppings_and_options_model.dart';
import 'package:hungry_app/features/products/ui/cubit/toppings_and_options_cubit.dart';
import 'package:hungry_app/features/products/ui/cubit/toppings_and_options_state.dart';
import 'package:hungry_app/features/products/ui/widgets/spicy_slider.dart';
import 'package:hungry_app/features/products/ui/widgets/toppings_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.productModel});
  final HomeProductModel productModel;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  List<ToppingsAndOptionsModel> toppings = [];
  List<ToppingsAndOptionsModel> options = [];
  double currentSpicyValue = 0.0;
  List<int> selectedTopping = [];
  List<int> selectedOption = [];
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Skeletonizer(
      enabled: toppings.isEmpty || options.isEmpty,
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: widget.productModel.name,
            textStyle: AppTextStyle.textGreen20WBold,
          ),
          centerTitle: true,
          leading: customBackButton(context),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
            child:
                BlocConsumer<ToppingsAndOptionsCubit, ToppingsAndOptionsState>(
                  listener: (context, state) {
                    if (state is GetAllToppingsSuccess) {
                      toppings = state.toppings;
                    } else if (state is GetAllOptionsSuccess) {
                      options = state.options;
                    }
                    setState(() {});
                    if (state is GetAllToppingsFailure) {
                      customSnackBar(context, state.errMsg);
                    }
                    if (state is GetAllOptionsFailure) {
                      customSnackBar(context, state.errMsg);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SpicySlider(
                          imageUrl: widget.productModel.image,
                          value: currentSpicyValue,
                          label: currentSpicyValue == 0.0
                              ? "Not Spicy"
                              : currentSpicyValue == 0.1
                              ? "Spicy"
                              : "Very Spicy",
                          onChanged: (value) {
                            setState(() {
                              currentSpicyValue = value;
                            });
                          },
                        ),
                        heightSpace(deviceHeight * 0.05),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Toppings",
                              textStyle: AppTextStyle.textBrown16W600,
                            ),
                            heightSpace(deviceHeight * 0.02),
                            SingleChildScrollView(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(toppings.length, (
                                  index,
                                ) {
                                  final topping = toppings[index];
                                  // [1, 2, 3] =
                                  final bool isToppingSelected = selectedTopping
                                      .contains(topping.id);
                                  log("isToppingSelected: $selectedTopping");
                                  return ToppingsCard(
                                    image: topping.image,
                                    title: topping.name,
                                    isSelected: isToppingSelected,
                                    onAdd: () {
                                      setState(() {
                                        if (isToppingSelected) {
                                          selectedTopping.remove(topping.id);
                                        } else {
                                          selectedTopping.add(topping.id);
                                        }
                                        log(
                                          "selectedTopping: $selectedTopping",
                                        );
                                      });
                                    },
                                  );
                                }),
                              ),
                            ),
                            heightSpace(deviceHeight * 0.02),
                            const CustomText(
                              text: "Side Options",
                              textStyle: AppTextStyle.textBrown16W600,
                            ),
                            heightSpace(deviceHeight * 0.02),
                            SingleChildScrollView(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(options.length, (
                                  index,
                                ) {
                                  final option = options[index];
                                  final bool isOptionSelected = selectedOption
                                      .contains(option.id);
                                  log("isOptionSelected: $isOptionSelected");
                                  return ToppingsCard(
                                    image: option.image,
                                    title: option.name,
                                    isSelected: isOptionSelected,
                                    onAdd: () {
                                      setState(() {
                                        if (isOptionSelected) {
                                          selectedOption.remove(option.id);
                                        } else {
                                          selectedOption.add(option.id);
                                        }
                                        log("selectedOption: $selectedOption");
                                      });
                                    },
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                        heightSpace(deviceHeight * 0.01),
                        // Total Section
                      ],
                    );
                  },
                ),
          ),
        ),
        // Total Section
        bottomSheet: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is AddToCartSuccess) {
              customSnackBar(
                context,
                "Added to Cart Successfully",
                isErrorMessage: false,
              );
            } else if (state is AddToCartFailure) {
              customSnackBar(context, state.errMsg);
            }
          },
          builder: (context, state) {
            return CustomTotalWithButton(
              totalPrice: widget.productModel.price,
              buttonTitle: "Add to Cart",
              isLoading: state is AddToCartLoading,
              onTap: () async {
                final CartItemsModel items = CartItemsModel(
                  items: [
                    CartModel(
                      productId: widget.productModel.id,
                      quantity: 1,
                      spicy: currentSpicyValue,
                      toppings: selectedTopping,
                      sideOptions: selectedOption,
                    ),
                  ],
                );
                await context.read<CartCubit>().addToCart(items: items);
              },
            );
          },
        ),
      ),
    );
  }
}

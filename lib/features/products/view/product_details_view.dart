import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/components/custom_back_button.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/components/custom_total_with_button.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/custom_loading.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/home/data/models/home_product_model.dart';
import 'package:hungry_app/features/home/view/cubit/home_products_cubit.dart';
import 'package:hungry_app/features/home/view/cubit/home_products_state.dart';
import 'package:hungry_app/features/products/widgets/spicy_slider.dart';
import 'package:hungry_app/features/products/widgets/toppings_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.productModel});
  final HomeProductModel productModel;

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
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
          child: BlocBuilder<HomeProductsCubit, HomeProductsState>(
            builder: (context, state) {
              return Skeletonizer(
                enabled:
                    state is GetAllToppingsLoading ||
                    state is GetAllToppingsSuccess && state.toppings.isEmpty,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SpicySlider(
                      imageUrl: widget.productModel.image,
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
                    state is GetAllToppingsSuccess
                        ? Column(
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
                                  children: List.generate(
                                    state.toppings.length,
                                    (index) {
                                      final topping = state.toppings[index];
                                      return ToppingsCard(
                                        image: topping.image,
                                        title: topping.name,
                                        onTap: () {},
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // heightSpace(deviceHeight * 0.02),
                              // const CustomText(
                              //   text: "Side Options",
                              //   textStyle: AppTextStyle.textBrown16W600,
                              // ),
                              // heightSpace(deviceHeight * 0.02),
                              // SingleChildScrollView(
                              //   clipBehavior: Clip.none,
                              //   scrollDirection: Axis.horizontal,
                              //   child: Row(
                              //     children: List.generate(6, (index) {
                              //       return ToppingsCard(
                              //         image: AppAssets.coleslaw,
                              //         title: "Coleslaw",
                              //         onTap: () {},
                              //       );
                              //     }),
                              //   ),
                              // ),
                            ],
                          )
                        : customLoading(),
                    heightSpace(deviceHeight * 0.01),
                    // Total Section
                  ],
                ),
              );
            },
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/components/custom_back_button.dart';
import 'package:hungry_app/core/components/custom_button.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/components/custom_total_with_button.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/custom_snack_bar.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:hungry_app/features/cart/data/models/user_cart_model.dart';
import 'package:hungry_app/features/checkout/widgets/checkout_payment_method.dart';
import 'package:hungry_app/features/checkout/widgets/custom_order_details.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key, required this.userCart});
  final UserCartModel userCart;

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  String selectedValue = "Cash";

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    final userModel = context.watch<AuthCubit>().userModel;
    return Skeletonizer(
      enabled: userModel == null,
      child: Scaffold(
        appBar: AppBar(leading: customBackButton(context)),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
          child: BlocConsumer<AuthCubit, AuthState>(
            buildWhen: (previous, current) => current is GetProfileDataSuccess,
            listener: (context, state) {
              if (state is GetProfileDataFailed) {
                customSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Order summary",
                    textStyle: AppTextStyle.textBrown16W600.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  heightSpace(deviceHeight * 0.02),
                  CustomOrderDetails(
                    order: widget.userCart.totalPrice,
                    taxes: "3.50",
                    deliveryFees: "40.00",
                    total:
                        (double.parse(widget.userCart.totalPrice) + 3.50 + 40)
                            .toStringAsFixed(2),
                  ),
                  heightSpace(deviceHeight * 0.05),
                  CustomText(
                    text: "Payment methods",
                    textStyle: AppTextStyle.textBrown16W600.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  heightSpace(deviceHeight * 0.03),
                  // Cash Method
                  CheckoutPaymentMethod(
                    paymentMethod: "Cash on delivery",
                    paymentImage: AppAssets.cashOnDelivery,
                    radioValue: "Cash",
                    radioGroupValue: selectedValue,
                    onChanged: (value) =>
                        setState(() => selectedValue = value!),
                    onTap: () => setState(() => selectedValue = "Cash"),
                  ),
                  heightSpace(deviceHeight * 0.02),
                  // Visa Method
                  userModel?.visa?.isNotEmpty ?? false
                      ? CheckoutPaymentMethod(
                          paymentMethod: "Debit card",
                          paymentImage: AppAssets.visaMethod,
                          radioValue: "Visa",
                          radioGroupValue: selectedValue,
                          onChanged: (value) =>
                              setState(() => selectedValue = value!),
                          onTap: () => setState(() => selectedValue = "Visa"),
                          tileColor: Colors.blue.shade200,
                          isVisa: true,
                        )
                      : const SizedBox.shrink(),

                  Row(
                    children: [
                      Checkbox(
                        activeColor: AppColors.kPrimaryColor,
                        value: true,
                        onChanged: (value) {},
                        visualDensity: const VisualDensity(horizontal: -4),
                      ),

                      Expanded(
                        child: CustomText(
                          text: "Save card details for future payments",
                          textStyle: AppTextStyle.textGrey16W400.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),

        bottomSheet: CustomTotalWithButton(
          totalPrice: (double.parse(widget.userCart.totalPrice) + 3.50 + 40)
              .toStringAsFixed(2),
          buttonTitle: "Pay Now",
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => SizedBox(
                height: deviceHeight * 0.1,
                child: Dialog(
                  elevation: 50,
                  shadowColor: AppColors.kPrimaryColor,
                  backgroundColor: AppColors.kWhiteColor,
                  child: Container(
                    height: deviceHeight * 0.4,
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.05,
                      vertical: deviceHeight * 0.02,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          AppAssets.success,
                          width: deviceWidth * 0.3,
                        ),
                        const CustomText(
                          text: "Payment successful",
                          textStyle: AppTextStyle.textBrown16W600,
                        ),
                        heightSpace(deviceHeight * 0.02),
                        Expanded(
                          child: CustomText(
                            text:
                                "Your payment was successful.\nA receipt for this purchase has \nbeen sent to your email.",
                            textStyle: AppTextStyle.textGrey16W400.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ),
                        CustomButton(
                          title: "Done",
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

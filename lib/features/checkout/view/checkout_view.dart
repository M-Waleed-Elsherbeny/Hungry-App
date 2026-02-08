import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_back_button.dart';
import 'package:hungry_app/core/components/custom_button.dart';
import 'package:hungry_app/core/components/custom_total_with_button.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/checkout/widgets/checkout_payment_method.dart';
import 'package:hungry_app/features/checkout/widgets/custom_order_details.dart';

class CheckOutView extends StatefulWidget {
  const CheckOutView({super.key});

  @override
  State<CheckOutView> createState() => _CheckOutViewState();
}

class _CheckOutViewState extends State<CheckOutView> {
  String selectedValue = "Cash";
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(leading: customBackButton(context)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order summary",
              style: AppTextStyle.textBrown16W600.copyWith(fontSize: 20),
            ),
            heightSpace(deviceHeight * 0.02),

            const CustomOrderDetails(
              order: "16.99",
              taxes: "0.09",
              deliveryFees: "1.5",
              total: "18.59",
            ),

            heightSpace(deviceHeight * 0.05),
            Text(
              "Payment methods",
              style: AppTextStyle.textBrown16W600.copyWith(fontSize: 20),
            ),
            heightSpace(deviceHeight * 0.03),

            // Cash Method
            CheckoutPaymentMethod(
              paymentMethod: "Cash on delivery",
              paymentImage: AppAssets.cashOnDelivery,
              radioValue: "Cash",
              radioGroupValue: selectedValue,
              onChanged: (value) => setState(() => selectedValue = value!),
              onTap: () => setState(() => selectedValue = "Cash"),
            ),
            heightSpace(deviceHeight * 0.02),
            // Visa Method
            CheckoutPaymentMethod(
              paymentMethod: "Debit card",
              paymentImage: AppAssets.visaMethod,
              radioValue: "Visa",
              radioGroupValue: selectedValue,
              onChanged: (value) => setState(() => selectedValue = value!),
              onTap: () => setState(() => selectedValue = "Visa"),
              tileColor: Colors.blue.shade200,
              isVisa: true,
            ),

            Row(
              children: [
                Checkbox(
                  activeColor: AppColors.kPrimaryColor,
                  value: true,
                  onChanged: (value) {},
                  visualDensity: const VisualDensity(horizontal: -4),
                ),

                Expanded(
                  child: Text(
                    "Save card details for future payments",
                    style: AppTextStyle.textGrey16W400.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      bottomSheet: CustomTotalWithButton(
        totalPrice: "25.99",
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
                      Image.asset(AppAssets.success, width: deviceWidth * 0.3),
                      const Text(
                        "Payment successful",
                        style: AppTextStyle.textBrown16W600,
                      ),
                      heightSpace(deviceHeight * 0.02),
                      Expanded(
                        child: Text(
                          "Your payment was successful.\nA receipt for this purchase has \nbeen sent to your email.",
                          style: AppTextStyle.textGrey16W400.copyWith(
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
    );
  }
}

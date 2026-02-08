import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_back_button.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/checkout/widgets/custom_order_details.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(leading: customBackButton(context)),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidth * 0.05,
          vertical: deviceHeight * 0.02,
        ),
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

            heightSpace(deviceHeight * 0.1),
            Text(
              "Payment methods",
              style: AppTextStyle.textBrown16W600.copyWith(fontSize: 20),
            ),
            heightSpace(deviceHeight * 0.05),

            ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.03,
                vertical: deviceHeight * 0.01,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: AppColors.kBrownColor,
              title: const Text(
                "Cash on delivery",
                style: AppTextStyle.textWhite16W500,
              ),
              leading: Image.asset(AppAssets.cashOnDelivery),
              trailing: Radio(
                value: "cash",
                groupValue: "cash",
                activeColor: AppColors.kWhiteColor,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

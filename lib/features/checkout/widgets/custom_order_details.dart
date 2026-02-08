import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';

class CustomOrderDetails extends StatelessWidget {
  const CustomOrderDetails({super.key, required this.order, required this.taxes, required this.deliveryFees, required this.total});
  final String order, taxes, deliveryFees, total;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        checkOutWidget("Order", order),
        checkOutWidget("Taxes", taxes),
        checkOutWidget("Delivery fees", deliveryFees),
        heightSpace(deviceHeight * 0.02),
        Divider(thickness: 1, color: Colors.grey.shade300),
        heightSpace(deviceHeight * 0.02),
        checkOutWidget("Total", total, style: AppTextStyle.textBrown18W700),
        heightSpace(deviceHeight * 0.02),
        checkOutWidget(
          "Estimated delivery time:",
          "15-30 minutes",
          style: AppTextStyle.textBrown14W400.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

Widget checkOutWidget(title, price, {TextStyle? style}) {
  return Row(
    children: [
      Text(title, style: style ?? AppTextStyle.textGrey18W500),
      const Spacer(),
      Text("\$$price", style: style ?? AppTextStyle.textGrey18W500),
    ],
  );
}

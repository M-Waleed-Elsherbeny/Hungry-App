import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_button.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';

class GuestProfile extends StatelessWidget {
  const GuestProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const CustomText(
              text: "You Must Login To View Profile :)",
              textStyle: AppTextStyle.textBrown18W700,
            ),
            CustomButton(
              title: "Login",
              textStyle: AppTextStyle.textWhite20WBold,
              minimumSize: const Size(double.infinity, 50),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRouterPaths.loginScreen,
                  (_) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

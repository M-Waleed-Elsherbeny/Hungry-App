import 'package:flutter/material.dart';
import 'package:hungry_app/core/components/custom_button.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/checkout/widgets/checkout_payment_method.dart';
import 'package:hungry_app/features/profile/widgets/custom_profile_text_field.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TextEditingController nameController,
      emailController,
      passwordController,
      deliveryAddressController;

  @override
  void initState() {
    nameController = TextEditingController(text: "Mohammed Waleed");
    emailController = TextEditingController(text: "Mohammed@gmail.com");
    passwordController = TextEditingController(text: "202020");
    deliveryAddressController = TextEditingController(text: "55Dubai, UAE");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
    final deviceHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
          child: Column(
            children: [
              heightSpace(deviceHeight * 0.05),
              Center(
                child: Container(
                  width: deviceWidth * 0.35,
                  height: deviceHeight * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.kWhiteColor, width: 3),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://i.pinimg.com/originals/d1/51/62/d15162b27cd9712860b90abe58cb60e7.jpg",
                      ),
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              heightSpace(deviceHeight * 0.05),
              CustomProfileTextField(
                controller: nameController,
                labelText: "Name",
              ),
              heightSpace(deviceHeight * 0.05),
              CustomProfileTextField(
                controller: emailController,
                labelText: "Email",
              ),
              heightSpace(deviceHeight * 0.05),
              CustomProfileTextField(
                controller: deliveryAddressController,
                labelText: "Delivery Address",
              ),
              heightSpace(deviceHeight * 0.05),
              CustomProfileTextField(
                controller: passwordController,
                isPassword: true,
                labelText: "Password 🔒",
                style: const TextStyle(
                  color: AppColors.kWhiteColor,
                  fontSize: 24,
                ),
              ),
              heightSpace(deviceHeight * 0.05),
              CheckoutPaymentMethod(
                paymentMethod: "Debit card",
                paymentImage: AppAssets.visaMethod,
                radioValue: "visa",
                radioGroupValue: "visa",
                onChanged: (value) {},
                onTap: () {},
                tileColor: Colors.grey.shade200,
                activeColor: AppColors.kPrimaryColor,
                isVisa: true,
              ),
              heightSpace(deviceHeight * 0.15),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: deviceHeight * 0.1,
        decoration: const BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          vertical: deviceHeight * 0.01,
          horizontal: deviceWidth * 0.05,
        ),
        child: Row(
          children: [
            CustomButton(title: "Edit Profile", onTap: () {}),
            const Spacer(),
            CustomButton(
              backgroundColor: AppColors.kLightWhiteColor,
              title: "Logout",
              textStyle: AppTextStyle.textGreen20WBold.copyWith(fontSize: 16),
              onTap: () {},
            ),
            heightSpace(deviceHeight * 0.1),
          ],
        ),
      ),
    );
  }
}

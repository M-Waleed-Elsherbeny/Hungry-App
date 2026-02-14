import 'package:flutter/material.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/utils/spacer.dart';
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
      body: Column(
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
          CustomProfileTextField(controller: nameController, labelText: "Name"),
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
            style: const TextStyle(color: AppColors.kWhiteColor, fontSize: 24),
          ),
          heightSpace(deviceHeight * 0.05),
        ],
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/components/custom_button.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/custom_loading.dart';
import 'package:hungry_app/core/utils/custom_snack_bar.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:hungry_app/features/checkout/widgets/checkout_payment_method.dart';
import 'package:hungry_app/features/profile/widgets/custom_profile_text_field.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? selectedValue;
  UserModel? user;

  @override
  void initState() {
    getProfileData();
    super.initState();
  }
  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> getProfileData() async {
    try {
      log(user.toString());
      if (user == null) {
        await context.read<AuthCubit>().getProfileData();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
    final deviceHeight = MediaQuery.sizeOf(context).height;
    return Container(
      width: deviceWidth,
      height: deviceHeight,
      color: AppColors.kPrimaryColor,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is GetProfileDataFailed) {
            customSnackBar(context, state.message);
          }
          if (state is GetProfileDataSuccess) {
            user = state.user;
            nameController.text = user!.name;
            emailController.text = user!.email;
            addressController.text = user!.address ?? "";
            setState(() {});
          }
        },
        builder: (context, state) {
          return state is GetProfileDataLoading
              ? customLoading()
              : state is GetProfileDataSuccess && user != null
              ? Column(
                  children: [
                    heightSpace(deviceHeight * 0.05),
                    Center(
                      child: Container(
                        width: deviceWidth * 0.35,
                        height: deviceHeight * 0.15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(user!.image!),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.contain,
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
                      controller: addressController,
                      labelText: "Delivery Address",
                    ),
                    heightSpace(deviceHeight * 0.05),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.05,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.kLightWhiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CheckoutPaymentMethod(
                          activeColor: AppColors.kPrimaryColor,
                          paymentMethod: "Debit card",
                          paymentImage: AppAssets.visaMethod,
                          radioValue: "Visa",
                          radioGroupValue: "Visa",
                          onChanged: (value) =>
                              setState(() => selectedValue = value!),
                          onTap: () => setState(() => selectedValue = "Visa"),
                          tileColor: AppColors.kWhiteColor,
                          isVisa: true,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: deviceWidth,
                      height: deviceHeight * 0.1,
                      color: AppColors.kWhiteColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomButton(title: "Edit Profile", onTap: () {}),
                          CustomButton(
                            backgroundColor: AppColors.kLightWhiteColor,
                            borderColor: AppColors.kPrimaryColor,
                            textStyle: AppTextStyle.textGreen18W500,
                            title: "Logout",
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CustomText(
                    text: "You Haven't an Account",
                    textStyle: AppTextStyle.textWhite20WBold,
                  ),
                );
        },
      ),
    );
  }
}

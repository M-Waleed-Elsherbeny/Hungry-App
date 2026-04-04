import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/components/custom_button.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
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
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController visaController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String selectedValue = "";
  UserModel? user;
  String? selectedImage;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => selectedImage = image.path);
    }
  }

  Future<void> updateProfileData() async {
    await context.read<AuthCubit>().updateProfileData(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      image: selectedImage,
      address: addressController.text.trim(),
      visa: visaController.text.trim(),
    );
  }

  @override
  void initState() {
    getProfileData();
    log(selectedImage ?? "No image");
    super.initState();
  }

  Future<void> getProfileData() async {
    await context.read<AuthCubit>().getProfileData().then((_) {
      log(user?.name ?? "No User");
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
    final deviceHeight = MediaQuery.sizeOf(context).height;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is GetProfileDataFailed) {
          customSnackBar(context, state.message);
        }
        if (state is UpdateProfileDataFailed) {
          customSnackBar(context, state.message);
        }
        if (state is UpdateProfileDataSuccess) {
          customSnackBar(
            context,
            "Profile Updated Successfully",
            isErrorMessage: false,
          );
        }
        if (state is GetProfileDataSuccess) {
          user = state.user;
          nameController.text = user!.name;
          emailController.text = user!.email;
          addressController.text = user?.address == null
              ? "No Address Added Yet..."
              : user!.address!;
          visaController.text = user?.visa == null
              ? "**** **** 5555"
              : user!.visa!;
          phoneController.text = user?.address ?? "0123456789";
          setState(() {});
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () => context.read<AuthCubit>().getProfileData(),
            backgroundColor: AppColors.kPrimaryColor,
            color: AppColors.kWhiteColor,
            child: SingleChildScrollView(
              child: Skeletonizer(
                enabled:
                    user == null ||
                    state is UpdateProfileDataLoading ||
                    state is GetProfileDataLoading,
                child: Column(
                  children: [
                    heightSpace(deviceHeight * 0.05),
                    Center(
                      child: Container(
                        width: deviceWidth * 0.35,
                        height: deviceHeight * 0.15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.kPrimaryColor,
                            width: 2,
                          ),
                        ),
                        child: selectedImage != null
                            ? Image.file(File(selectedImage!))
                            : user?.image != null
                            ? Image.network(
                                user!.image!,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                      Icons.person,
                                      size: deviceHeight * 0.1,
                                      color: AppColors.kPrimaryColor,
                                    ),
                              )
                            : Icon(
                                Icons.person,
                                size: deviceHeight * 0.1,
                                color: AppColors.kPrimaryColor,
                              ),
                      ),
                    ),
                    heightSpace(deviceHeight * 0.02),
                    CustomButton(
                      title: user?.image != null || selectedImage != null
                          ? "Change Image"
                          : "Upload Image",
                      onTap: pickImage,
                    ),
                    heightSpace(deviceHeight * 0.05),
                    CustomProfileTextField(
                      controller: nameController,
                      labelText: "Name",
                      labelStyle: AppTextStyle.textBrown16W400,
                      style: AppTextStyle.textBrown16W400,
                      borderColor: AppColors.kPrimaryColor,
                    ),
                    heightSpace(deviceHeight * 0.05),
                    CustomProfileTextField(
                      controller: emailController,
                      labelText: "Email",
                      labelStyle: AppTextStyle.textBrown16W400,
                      style: AppTextStyle.textBrown16W400,
                      borderColor: AppColors.kPrimaryColor,
                    ),
                    heightSpace(deviceHeight * 0.05),
                    CustomProfileTextField(
                      controller: addressController,
                      labelText: "Delivery Address",
                      labelStyle: AppTextStyle.textBrown16W400,
                      style: AppTextStyle.textBrown16W400,
                      borderColor: AppColors.kPrimaryColor,
                    ),
                    heightSpace(deviceHeight * 0.05),
                    CustomProfileTextField(
                      controller: phoneController,
                      labelText: "Type your Phone",
                      labelStyle: AppTextStyle.textBrown16W400,
                      style: AppTextStyle.textBrown16W400,
                      borderColor: AppColors.kPrimaryColor,
                    ),
                    heightSpace(deviceHeight * 0.05),
                    CustomProfileTextField(
                      controller: visaController,
                      labelText: "ADD VISA",
                      labelStyle: AppTextStyle.textBrown16W400,
                      style: AppTextStyle.textBrown16W400,
                      borderColor: AppColors.kPrimaryColor,
                    ),
                    heightSpace(deviceHeight * 0.05),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.05,
                      ),
                      child: CheckoutPaymentMethod(
                        paymentMethod: "Debit card",
                        paymentImage: AppAssets.visaMethod,
                        radioValue: "Visa",
                        radioGroupValue: selectedValue,
                        onChanged: (value) =>
                            setState(() => selectedValue = value!),
                        onTap: () => setState(() => selectedValue = "Visa"),
                        tileColor: Colors.blue.shade200,
                        isVisa: true,
                      ),
                    ),
                    heightSpace(deviceHeight * 0.3),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: Container(
            width: deviceWidth,
            height: deviceHeight * 0.1,
            decoration: const BoxDecoration(
              color: AppColors.kLightWhiteColor,
              border: Border(
                top: BorderSide(color: AppColors.kPrimaryColor, width: 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: updateProfileData,
                  child: state is UpdateProfileDataLoading
                      ? customLoading()
                      : const CustomText(
                          text: "Edit Profile",
                          textStyle: AppTextStyle.textWhite16W500,
                        ),
                ),
                CustomButton(
                  backgroundColor: AppColors.kLightWhiteColor,
                  borderColor: AppColors.kPrimaryColor,
                  child: state is AuthLogoutLoading
                      ? customLoading(color: AppColors.kPrimaryColor)
                      : const CustomText(
                          text: "Logout",
                          textStyle: AppTextStyle.textGreen18W500,
                        ),
                  onTap: () {
                    context.read<AuthCubit>().logout().then((_) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouterPaths.loginScreen,
                        (root) => false,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

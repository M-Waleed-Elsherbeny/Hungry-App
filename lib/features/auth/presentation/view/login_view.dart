import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hungry_app/core/components/custom_button.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
import 'package:hungry_app/core/utils/custom_loading.dart';
import 'package:hungry_app/core/utils/custom_snack_bar.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:hungry_app/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  validLogin() {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            heightSpace(deviceHeight * 0.2),
            SvgPicture.asset(
              AppAssets.logoHungry,
              colorFilter: const ColorFilter.mode(
                AppColors.kPrimaryColor,
                BlendMode.srcIn,
              ),
            ),
            heightSpace(deviceHeight * 0.02),
            CustomText(
              text: "Welcome Back, Discover The Best Food!",
              textStyle: AppTextStyle.textBrown16W600.copyWith(fontSize: 14.sp),
            ),
            heightSpace(deviceHeight * 0.06),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
                decoration: const BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoginFailed) {
                      customSnackBar(context, state.message);
                    }
                    if (state is AuthLoginSuccess) {
                      customSnackBar(
                        context,
                        "Login Successfully",
                        isErrorMessage: false,
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouterPaths.bottomNavigationBar,
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            heightSpace(deviceHeight * 0.03),
                            CustomTextFormField(
                              controller: emailController,
                              fieldName: "Email",
                              hintText: "Type your Email",
                              prefixIcon: Icons.email,
                            ),
                            heightSpace(deviceHeight * 0.03),
                            CustomTextFormField(
                              controller: passwordController,
                              fieldName: "Password",
                              hintText: "Type your Password",
                              prefixIcon: CupertinoIcons.lock_fill,
                              suffixIcon: isPassword
                                  ? CupertinoIcons.eye
                                  : CupertinoIcons.eye_slash,
                              isPassword: !isPassword,
                              onTapSuffixIcon: () {
                                setState(() {
                                  isPassword = !isPassword;
                                });
                              },
                            ),
                            heightSpace(deviceHeight * 0.05),
                            CustomButton(
                              minimumSize: Size(
                                deviceWidth,
                                deviceHeight * 0.06,
                              ),
                              onTap: validLogin,
                              child: state is AuthLoginLoading
                                  ? customLoading()
                                  :  CustomText(
                                      text: "Login",
                                      textStyle: AppTextStyle.textWhite20WBold,
                                    ),
                            ),
                            heightSpace(deviceHeight * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: CustomButton(
                                    title: "New Account",
                                    textStyle: AppTextStyle.textGreen16W500
                                        .copyWith(fontSize: 14.sp),
                                    backgroundColor: AppColors.kLightWhiteColor,
                                    onTap: () => Navigator.pushReplacementNamed(
                                      context,
                                      AppRouterPaths.signUpScreen,
                                    ),
                                  ),
                                ),
                                widthSpace(10),
                                Expanded(
                                  child: CustomButton(
                                    title: "As a Guest ?",
                                    textStyle: AppTextStyle.textGreen16W500
                                        .copyWith(fontSize: 14.sp),
                                    backgroundColor: AppColors.kLightWhiteColor,
                                    onTap: () => Navigator.pushReplacementNamed(
                                      context,
                                      AppRouterPaths.bottomNavigationBar,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

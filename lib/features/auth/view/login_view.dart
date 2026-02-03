import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hungry_app/features/auth/widgets/custom_auth_button.dart';
import 'package:hungry_app/features/auth/widgets/custom_text_form_field.dart';
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
    if (formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.logoHungry),
                    heightSpace(deviceHeight * 0.02),
                    const Text(
                      "Welcome Back, Discover The Best Food!",
                      style: AppTextStyle.textWhite14W600,
                    ),
                    heightSpace(deviceHeight * 0.1),
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
                    heightSpace(deviceHeight * 0.1),
                    CustomAuthButton(title: "Login", onTap: validLogin),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

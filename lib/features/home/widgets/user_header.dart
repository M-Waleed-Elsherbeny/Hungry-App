import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hungry_app/core/components/custom_text.dart';
import 'package:hungry_app/core/styles/assets/app_assets.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key, this.userModel});
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppAssets.logoHungry,
              colorFilter: const ColorFilter.mode(
                AppColors.kPrimaryColor,
                BlendMode.srcIn,
              ),
              width: deviceWidth * 0.5,
            ),
            heightSpace(deviceHeight * 0.01),
            CustomText(
              text: "Hello, ${userModel?.name ?? "User"}",
              textStyle: AppTextStyle.textGrey18W500,
            ),
          ],
        ),
        const Spacer(),
        userModel?.image == null
            ? const CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.kGreyColor,
              )
            : CircleAvatar(
                radius: 35,
                child: Image.network(userModel!.image!),
              ),
      ],
    );
  }
}

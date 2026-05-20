import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry_app/core/styles/fonts/app_text_style.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';

class ToppingsCard extends StatelessWidget {
  const ToppingsCard({
    super.key,
    required this.image,
    required this.title,
    required this.onAdd,
    required this.isSelected,
  });
  final String image, title;
  final VoidCallback onAdd;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onAdd,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: deviceWidth * 0.30,
                height: deviceHeight * 0.15,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: AppColors.kWhiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: deviceWidth * 0.30,
                  height: deviceHeight * 0.15,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.kPrimaryColor.withAlpha(150)
                        : AppColors.kBrownColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: deviceHeight * 0.01,
                      left: deviceWidth * 0.02,
                      right: deviceWidth * 0.01,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            title,
                            style: AppTextStyle.textWhite12W500,
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          child: CircleAvatar(
                            radius: deviceHeight * 0.010,
                            backgroundColor: isSelected
                                ? AppColors.kWhiteColor
                                : AppColors.kRedColor,
                            child: Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.add_outlined,
                              size: 15.w,
                              color: isSelected
                                  ? AppColors.kPrimaryColor
                                  : AppColors.kWhiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: deviceWidth * 0.30,
                  height: deviceHeight * 0.1,
                  decoration: BoxDecoration(
                    color: AppColors.kWhiteColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

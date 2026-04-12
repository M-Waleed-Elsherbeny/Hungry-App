import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:hungry_app/features/home/widgets/card_grid_view.dart';
import 'package:hungry_app/features/home/widgets/food_categories.dart';
import 'package:hungry_app/features/home/widgets/search_bar_view.dart';
import 'package:hungry_app/features/home/widgets/user_header.dart';
import 'package:hungry_app/main.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool hasUser = hasToken;
  @override
  void initState() {
    isUser();
    log("hasUser initState: $hasUser");
    hasUser ? context.read<AuthCubit>().getProfileData() : null;
    super.initState();
  }

  Future<void> isUser() async {
    hasUser = await PrefHelper.isUser();
    log("hasUser isUser: $hasUser");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    final userModel = context.watch<AuthCubit>().userModel;
    log("isGuest build: $hasUser");
    return RefreshIndicator(
      onRefresh: () => context.read<AuthCubit>().getProfileData(),
      backgroundColor: AppColors.kPrimaryColor,
      color: AppColors.kWhiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              heightSpace(deviceHeight * 0.03),
              // Header Section
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previous, current) =>
                    current is GetProfileDataSuccess || userModel == null,

                builder: (context, state) {
                  return Skeletonizer(
                    enabled: state is GetProfileDataLoading,
                    child: UserHeader(userModel: userModel),
                  );
                },
              ),
              heightSpace(deviceHeight * 0.03),
              // Search Bar
              const SearchBarView(),
              heightSpace(deviceHeight * 0.03),
              // Categories
              const FoodCategories(),
              heightSpace(deviceHeight * 0.03),
              // Food Items
              const CardGridView(),
            ],
          ),
        ),
      ),
    );
  }
}

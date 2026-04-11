import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/auth/data/models/user_model.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:hungry_app/features/home/widgets/card_grid_view.dart';
import 'package:hungry_app/features/home/widgets/food_categories.dart';
import 'package:hungry_app/features/home/widgets/search_bar_view.dart';
import 'package:hungry_app/features/home/widgets/user_header.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  UserModel? userModel;

  @override
  void initState() {
    context.read<AuthCubit>().getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              heightSpace(deviceHeight * 0.03),
              // Header Section
              BlocConsumer<AuthCubit, AuthState>(
                buildWhen: (previous, current) =>
                    current is GetProfileDataSuccess ||
                    current is GetProfileDataFailed,
                listener: (context, state) {
                  if (state is GetProfileDataSuccess) {
                    userModel = state.user;
                  }
                },
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

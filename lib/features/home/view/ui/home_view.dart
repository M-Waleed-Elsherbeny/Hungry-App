import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry_app/core/styles/colors/app_colors.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';
import 'package:hungry_app/core/utils/spacer.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:hungry_app/features/home/data/models/home_product_model.dart';
import 'package:hungry_app/features/home/view/cubit/home_products_cubit.dart';
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
  List<HomeProductModel?>? products;
  TextEditingController searchController = TextEditingController();
  bool hasUser = hasToken;
  @override
  void initState() {
    isUser();
    hasUser ? context.read<AuthCubit>().getProfileData() : null;

    super.initState();
  }

  Future<void> isUser() async {
    hasUser = await PrefHelper.isUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<AuthCubit>().userModel;
    final allProducts = context.watch<HomeProductsCubit>().allProducts;
    return RefreshIndicator(
      onRefresh: () => context.read<AuthCubit>().getProfileData(),
      backgroundColor: AppColors.kPrimaryColor,
      color: AppColors.kWhiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              heightSpace(10),
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
              heightSpace(10),
              // Search Bar
              SearchBarView(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    products = allProducts
                        .where(
                          (q) => q!.name.toLowerCase().contains(
                            value.toLowerCase(),
                          ),
                        )
                        .toList();
                  });
                },
              ),
              heightSpace(10),
              // Categories
              const FoodCategories(),
              heightSpace(15),
              // Food Items
              CardGridView(products: products ?? allProducts),
            ],
          ),
        ),
      ),
    );
  }
}

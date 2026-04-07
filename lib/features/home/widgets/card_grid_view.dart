import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
import 'package:hungry_app/core/utils/custom_snack_bar.dart';
import 'package:hungry_app/features/home/data/models/home_product_model.dart';
import 'package:hungry_app/features/home/view/cubit/home_products_cubit.dart';
import 'package:hungry_app/features/home/view/cubit/home_products_state.dart';
import 'package:hungry_app/features/home/widgets/card_details_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CardGridView extends StatefulWidget {
  const CardGridView({super.key});

  @override
  State<CardGridView> createState() => _CardGridViewState();
}

class _CardGridViewState extends State<CardGridView> {
  List<HomeProductModel>? products = [];

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeProductsCubit, HomeProductsState>(
      listener: (context, state) {
        if (state is GetAllProductsError) {
          customSnackBar(context, state.errMsg);
        } else if (state is GetAllProductsSuccess) {
          products = state.products!;
          setState(() {});
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: products == null || state is GetAllProductsLoading,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: deviceWidth * 0.02,
              mainAxisSpacing: deviceHeight * 0.02,
              childAspectRatio: deviceWidth / (deviceHeight * 0.55),
            ),
            itemCount: products!.length,
            itemBuilder: (_, index) {
              final product = products![index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRouterPaths.productDetails,
                    arguments: product,
                  );
                },
                child: CardDetailsView(
                  image: product.image,
                  title: product.name,
                  subtitle: product.description,
                  rate: product.rating,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

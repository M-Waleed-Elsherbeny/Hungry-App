import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/core/navigation/router/app_router_paths.dart';
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
  @override
  void initState() {
    context.read<HomeProductsCubit>().getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeProductsCubit, HomeProductsState>(
      builder: (context, state) {
        List<HomeProductModel?> products = context
            .watch<HomeProductsCubit>()
            .products;
        return Skeletonizer(
          enabled: products.isEmpty || state is GetAllProductsLoading,
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
            itemCount: products.length,
            itemBuilder: (_, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRouterPaths.productDetails);
                },
                child: CardDetailsView(
                  image: products[index]!.image,
                  title: products[index]!.name,
                  subtitle: products[index]!.description,
                  rate: products[index]!.rating,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

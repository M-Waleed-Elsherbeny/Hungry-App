import 'package:hungry_app/features/home/data/models/home_product_model.dart';
import 'package:hungry_app/features/home/data/models/toppings_model.dart';

abstract class HomeProductsState {}

final class HomeProductsInitial extends HomeProductsState {}

final class GetAllProductsLoading extends HomeProductsState {}

final class GetAllProductsSuccess extends HomeProductsState {
  final List<HomeProductModel>? products;
  GetAllProductsSuccess({required this.products});
}

final class GetAllProductsError extends HomeProductsState {
  final String errMsg;
  GetAllProductsError({required this.errMsg});
}

final class GetAllToppingsLoading extends HomeProductsState {}

final class GetAllToppingsSuccess extends HomeProductsState {
  final List<ToppingsModel> toppings;
  GetAllToppingsSuccess({required this.toppings});
}

final class GetAllToppingsError extends HomeProductsState {
  final String errMsg;
  GetAllToppingsError({required this.errMsg});
}

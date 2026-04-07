import 'package:hungry_app/features/cart/data/models/user_cart_model.dart';

abstract class CartState {}

final class CartInitial extends CartState {}

final class AddToCartLoading extends CartState {}

final class AddToCartSuccess extends CartState {}

final class AddToCartFailure extends CartState {
  final String errMsg;

  AddToCartFailure({required this.errMsg});
}

final class GetUserCartLoading extends CartState {}

final class GetUserCartSuccess extends CartState {
  final UserCartModel? cartModel;

  GetUserCartSuccess({required this.cartModel});
}

final class GetUserCartFailure extends CartState {
  final String errMsg;

  GetUserCartFailure({required this.errMsg});
}

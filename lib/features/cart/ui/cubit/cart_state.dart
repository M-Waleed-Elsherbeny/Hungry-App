abstract class CartState {}

final class CartInitial extends CartState {}

final class AddToCartLoading extends CartState {}

final class AddToCartSuccess extends CartState {}

final class AddToCartFailure extends CartState {
  final String errMsg;

  AddToCartFailure({required this.errMsg});
}

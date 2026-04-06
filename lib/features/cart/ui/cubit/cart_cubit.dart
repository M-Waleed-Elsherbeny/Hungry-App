import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/features/cart/data/models/cart_model.dart';
import 'package:hungry_app/features/cart/data/repo/cart_repo.dart';
import 'package:hungry_app/features/cart/ui/cubit/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo _cartRepo;
  CartCubit(this._cartRepo) : super(CartInitial());

  Future<void> addToCart({required CartItemsModel items}) async {
    emit(AddToCartLoading());
    final response = await _cartRepo.addToCart(items: items);
    response.fold(
      (error) => emit(AddToCartFailure(errMsg: error.errMessage)),
      (_) => emit(AddToCartSuccess()),
    );
  }
}

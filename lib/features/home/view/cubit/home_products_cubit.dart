import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/features/home/data/repo/home_repo.dart';
import 'package:hungry_app/features/home/view/cubit/home_products_state.dart';

class HomeProductsCubit extends Cubit<HomeProductsState> {
  final HomeRepo _homeRepo;
  HomeProductsCubit(this._homeRepo) : super(HomeProductsInitial());
  Future<void> getAllProducts() async {
    emit(GetAllProductsLoading());
    final response = await _homeRepo.getAllProducts();
    response.fold(
      (error) => emit(GetAllProductsError(errMsg: error.errMessage)),
      (products) => emit(GetAllProductsSuccess(products: products)),
    );
  }

  Future<void> getToppings() async {
    emit(GetAllToppingsLoading());
    final response = await _homeRepo.getToppings();
    response.fold(
      (error) => emit(GetAllToppingsError(errMsg: error.errMessage)),
      (toppings) => emit(GetAllToppingsSuccess(toppings: toppings)),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/features/home/data/models/home_product_model.dart';
import 'package:hungry_app/features/home/data/repo/home_repo.dart';
import 'package:hungry_app/features/home/view/cubit/home_products_state.dart';

class HomeProductsCubit extends Cubit<HomeProductsState> {
  final HomeRepo _homeRepo;
  HomeProductsCubit(this._homeRepo) : super(HomeProductsInitial());

  List<HomeProductModel> products = [];

  Future<void> getAllProducts() async {
    emit(GetAllProductsLoading());
    final response = await _homeRepo.getAllProducts();
    response.fold(
      ifLeft: (error) => GetAllProductsError(errMsg: error.errMessage),
      ifRight: (products) => GetAllProductsSuccess(products: products),
    );
  }
}

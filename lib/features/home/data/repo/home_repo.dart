import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry_app/core/constants/api_constant.dart';
import 'package:hungry_app/core/errors/custom_exception.dart';
import 'package:hungry_app/core/errors/failure.dart';
import 'package:hungry_app/core/networking/api_services.dart';
import 'package:hungry_app/features/home/data/models/home_product_model.dart';

class HomeRepo {
  final ApiServices _apiServices = ApiServices();
  List<HomeProductModel> products = [];

  /// Get All Products
  Future<Either<Failure, List<HomeProductModel>?>> getAllProducts() async {
    try {
      final response = await _apiServices.get(
        endPoint: ApiConstants.productsEndPoint,
      );
      for (var product in response.data["data"]) {
        // log("product: $product");
        products.add(HomeProductModel.fromJson(product));
      }
      return Right(products);
    } on DioException catch (error) {
      log("DioException getAllProducts: $error");
      return Left(ServerFailure.fromDioException(error));
    } on CustomException catch (e) {
      log("CustomException getAllProducts: $e");
      return Left(ServerFailure(errMessage: e.errMessage));
    }
  }

  
}

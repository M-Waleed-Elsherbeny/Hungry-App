import 'dart:developer';

import 'package:dart_either/dart_either.dart';
import 'package:dio/dio.dart';
import 'package:hungry_app/core/constants/api_constant.dart';
import 'package:hungry_app/core/errors/failure.dart';
import 'package:hungry_app/core/networking/api_services.dart';
import 'package:hungry_app/features/home/data/models/home_product_model.dart';

class HomeRepo {
  final ApiServices _apiServices = ApiServices();
  List<HomeProductModel> products = [];

  Future<Either<Failure, List<HomeProductModel>?>> getAllProducts() async {
    try {
      final response = await _apiServices.get(ApiConstants.productsEndPoint);
      log("Response: $response");
      for (var product in response["data"]) {
        products.add(HomeProductModel.fromJson(product));
      }
      return Right(products);
    } on DioException catch (error) {
      log("DioException getAllProducts: $error");
      return Left(ServerFailure.fromDioException(error));
    } catch (e) {
      log("Catch getAllProducts: $e");
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}

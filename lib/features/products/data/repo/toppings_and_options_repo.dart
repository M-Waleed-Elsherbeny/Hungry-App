import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry_app/core/constants/api_constant.dart';
import 'package:hungry_app/core/errors/custom_exception.dart';
import 'package:hungry_app/core/errors/failure.dart';
import 'package:hungry_app/core/networking/api_services.dart';
import 'package:hungry_app/features/products/data/models/toppings_and_options_model.dart';

class ToppingsAndOptionsRepo {
  final ApiServices _apiServices = ApiServices();
  List<ToppingsAndOptionsModel> toppings = [];
  List<ToppingsAndOptionsModel> options = [];

  /// Get Toppings
  Future<Either<Failure, List<ToppingsAndOptionsModel>>> getToppings() async {
    try {
      final response = await _apiServices.get(
        endPoint: ApiConstants.toppingsEndPoint,
      );
      for (var topping in response.data["data"]) {
        toppings.add(ToppingsAndOptionsModel.fromJson(topping));
      }
      return Right(toppings);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.errMessage));
    }
  }

  /// Get Toppings Options
  Future<Either<Failure, List<ToppingsAndOptionsModel>>> getToppingsOptions() async {
    try {
      final response = await _apiServices.get(
        endPoint: ApiConstants.optionsEndPoint,
      );
      for (var option in response.data["data"]) {
        options.add(ToppingsAndOptionsModel.fromJson(option));
      }
      return Right(options);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.errMessage));
    }
  }
}
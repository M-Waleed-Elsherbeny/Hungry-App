import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hungry_app/core/constants/api_constant.dart';
import 'package:hungry_app/core/errors/custom_exception.dart';
import 'package:hungry_app/core/errors/failure.dart';
import 'package:hungry_app/core/networking/api_services.dart';
import 'package:hungry_app/features/cart/data/models/cart_model.dart';
import 'package:hungry_app/features/cart/data/models/user_cart_model.dart';

class CartRepo {
  final ApiServices _apiServices = ApiServices();

  /// Add Cart
  Future<Either<Failure, void>> addToCart({
    required CartItemsModel items,
  }) async {
    try {
      await _apiServices.post(
        endPoint: ApiConstants.addCartEndPoint,
        data: items.toJson(),
      );
      return const Right(null);
    } on DioException catch (error) {
      return Left(ServerFailure.fromDioException(error));
    } on CustomException catch (error) {
      return Left(ServerFailure(errMessage: error.errMessage));
    }
  }

  /// Get Cart
  Future<Either<Failure, UserCartModel?>> getCart() async {
    try {
      final response = await _apiServices.get(
        endPoint: ApiConstants.getCartEndPoint,
      );
      if (response.statusCode == 200) {
        UserCartModel cartModel = UserCartModel.fromJson(response.data["data"]);
        return Right(cartModel);
      } else {
        return const Right(null);
      }
    } on DioException catch (error) {
      return Left(ServerFailure.fromDioException(error));
    } on CustomException catch (error) {
      return Left(ServerFailure(errMessage: error.errMessage));
    }
  }

  /// Delete Cart
  Future<Either<Failure, void>> deleteFromCart({required int id}) async {
    try {
      await _apiServices.delete(
        endPoint: "${ApiConstants.deleteCartEndPoint}/$id",
      );
      return const Right(null);
    } on DioException catch (error) {
      return Left(ServerFailure.fromDioException(error));
    } on CustomException catch (e) {
      return Left(ServerFailure(errMessage: e.errMessage));
    }
  }
}

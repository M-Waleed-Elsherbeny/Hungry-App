import 'dart:developer';

class CustomException implements Exception {
  final String errMessage;
  final int? statusCode;
  CustomException({required this.errMessage, this.statusCode});

  @override
  String toString() {
    log("CustomException: $errMessage");
    return errMessage;
  }
}

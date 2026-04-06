
import 'package:hungry_app/features/products/data/models/toppings_and_options_model.dart';

abstract class ToppingsAndOptionsState {}

final class ToppingsAndOptionsInitial extends ToppingsAndOptionsState {}
final class GetAllToppingsLoading extends ToppingsAndOptionsState {}

final class GetAllToppingsSuccess extends ToppingsAndOptionsState {
  final List<ToppingsAndOptionsModel> toppings;
  GetAllToppingsSuccess({required this.toppings});
}

final class GetAllToppingsFailure extends ToppingsAndOptionsState {
  final String errMsg;
  GetAllToppingsFailure({required this.errMsg});
}
final class GetAllOptionsLoading extends ToppingsAndOptionsState {}

final class GetAllOptionsSuccess extends ToppingsAndOptionsState {
  final List<ToppingsAndOptionsModel> options;
  GetAllOptionsSuccess({required this.options});
}

final class GetAllOptionsFailure extends ToppingsAndOptionsState {
  final String errMsg;
  GetAllOptionsFailure({required this.errMsg});
}

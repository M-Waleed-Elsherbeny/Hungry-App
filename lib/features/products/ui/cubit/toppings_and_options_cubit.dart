import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry_app/features/products/data/repo/toppings_and_options_repo.dart';
import 'package:hungry_app/features/products/ui/cubit/toppings_and_options_state.dart';

class ToppingsAndOptionsCubit extends Cubit<ToppingsAndOptionsState> {
  final ToppingsAndOptionsRepo _repo;
  ToppingsAndOptionsCubit(this._repo) : super(ToppingsAndOptionsInitial());

  Future<void> getToppings() async {
    emit(GetAllToppingsLoading());
    final response = await _repo.getToppings();
    response.fold(
      (error) => emit(GetAllToppingsFailure(errMsg: error.errMessage)),
      (toppings) => emit(GetAllToppingsSuccess(toppings: toppings)),
    );
  }

  Future<void> getOptions() async {
    emit(GetAllOptionsLoading());
    final response = await _repo.getToppingsOptions();
    response.fold(
      (error) => emit(GetAllOptionsFailure(errMsg: error.errMessage)),
      (options) => emit(GetAllOptionsSuccess(options: options)),
    );
  }
  Future<void> getToppingAndOptions() async {
    await getToppings();
    await getOptions();
  }
}

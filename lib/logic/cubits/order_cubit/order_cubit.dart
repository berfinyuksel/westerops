import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/order_repository.dart';
import '../generic_state/generic_state.dart';

class OrderCubit extends Cubit<GenericState> {
  final OrderRepository _orderRepository;
  OrderCubit(this._orderRepository) : super(GenericInitial());

  Future<void> deleteBasket(String boxId) async {
    try {
      emit(GenericLoading());
      final response = await _orderRepository.deleteBasket(boxId);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> getBasket() async {
    try {
      emit(GenericLoading());
      final response = await _orderRepository.getBasket();
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> clearBasket() async {
    try {
      emit(GenericLoading());
      final response = await _orderRepository.clearBasket();
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

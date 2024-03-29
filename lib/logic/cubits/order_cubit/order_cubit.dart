import 'package:dongu_mobile/data/model/box_order.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import '../../../data/repositories/order_repository.dart';
import '../generic_state/generic_state.dart';

class OrderCubit extends Cubit<GenericState> {
  final OrderRepository _orderRepository;
  OrderCubit(this._orderRepository) : super(GenericInitial());

  List<BoxOrder> itemList = [];
  double totalPrice = 0;

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
      itemList.clear();
      totalPrice = 0;
      for (int i = 0; i < response.length; i++) {
        itemList.add(response[i]);
      }
      _totalPayPrice();
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

  double _totalPayPrice() {
    for (var item in itemList) {
      totalPrice =
          totalPrice + item.packageSetting!.minDiscountedOrderPrice!.toDouble();
    }
    return totalPrice;
  }
}

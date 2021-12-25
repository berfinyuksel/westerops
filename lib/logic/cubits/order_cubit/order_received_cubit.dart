import '../../../data/repositories/order_received_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../generic_state/generic_state.dart';

class OrderReceivedCubit extends Cubit<GenericState> {
  final OrderReceivedRepository _orderReceivedRepository;
  OrderReceivedCubit(this._orderReceivedRepository) : super(GenericInitial());
  Future<void> createOrderWithRegisteredCard({
    required int deliveryType,
    required int addressId,
    required int billingAddressId,
    required String cardToken,
    required String ip,
  }) async {
    try {
      emit(GenericLoading());
      final response =
          await _orderReceivedRepository.createOrderWithRegisteredCard(
              deliveryType, addressId, billingAddressId, cardToken, ip);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> getOrder() async {
    try {
      emit(GenericLoading());
      final response = await _orderReceivedRepository.getOrder();
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

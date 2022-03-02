import '../../../data/repositories/order_received_repository.dart';
import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import '../generic_state/generic_state.dart';

part 'order_received_state.dart';

class OrderReceivedCubit extends Cubit<GenericState> {
  final SampleOrderReceivedRepository _orderReceivedRepository;
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
      final response = await _orderReceivedRepository.createOrderWithRegisteredCard(
          deliveryType, addressId, billingAddressId, cardToken, ip);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> createOrderWithout3D({
    required int deliveryType,
    required int addressId,
    required int billingAddressId,
    required String cardAlias,
    required String cardHolderName,
    required String cardNumber,
    required String expireMonth,
    required int registerCard,
    required String expireYear,
    required String cvc,
    required String ip,
  }) async {
    try {
      emit(GenericLoading());
      final response = await _orderReceivedRepository.createOrderWithout3D(deliveryType, addressId, billingAddressId,
          cardAlias, cardHolderName, cardNumber, expireMonth, expireYear, registerCard, cvc, ip);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> getPastOrder() async {
    try {
      emit(GenericLoading());
      final response = await _orderReceivedRepository.getOrder();
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> getPastOrderById(int id) async {
    try {
      emit(GenericLoading());
      final response = await _orderReceivedRepository.getOrderById(id);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

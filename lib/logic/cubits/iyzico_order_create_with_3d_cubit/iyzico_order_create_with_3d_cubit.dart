import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_creat_order_with_3d.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../generic_state/generic_state.dart';

class IyzicoOrderCreateWith3DCubit extends Cubit<GenericState> {
  final IyzicoCreateOrderWith3DRepository _iyzicoCreateOrderWith3DRepository;
  IyzicoOrderCreateWith3DCubit(this._iyzicoCreateOrderWith3DRepository)
      : super(GenericInitial());

  Future<void> createOrderWith3D(
      {required int deliveryType,
      required int addressId,
      required int billingAddressId,
      required String cardAlias,
      required String cardHolderName,
      required String cardNumber,
      required String expireMonth,
      required int registerCard,
      required String expireYear,
      required String cvc,
      required String ip}) async {
    try {
      emit(GenericLoading());
      final response =
          await _iyzicoCreateOrderWith3DRepository.createOrderWith3D(
              deliveryType,
              addressId,
              billingAddressId,
              cardAlias,
              cardHolderName,
              cardNumber,
              expireMonth,
              expireYear,
              registerCard,
              cvc,
              ip);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

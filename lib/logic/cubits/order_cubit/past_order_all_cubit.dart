import '../../../data/repositories/order_received_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import '../generic_state/generic_state.dart';

class PastOrderAllCubit extends Cubit<GenericState> {
  final OrderReceivedRepository _orderReceivedRepository;
  PastOrderAllCubit(this._orderReceivedRepository) : super(GenericInitial());

  Future<void> getPastOrder() async {
    try {
      emit(GenericLoading());
      final response = await _orderReceivedRepository.getOrder();
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

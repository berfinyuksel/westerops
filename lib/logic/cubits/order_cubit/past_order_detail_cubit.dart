import '../../../data/repositories/order_received_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import '../generic_state/generic_state.dart';

class PastOrderDetailCubit extends Cubit<GenericState> {
  final OrderReceivedRepository _orderReceivedRepository;
  PastOrderDetailCubit(this._orderReceivedRepository) : super(GenericInitial());

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

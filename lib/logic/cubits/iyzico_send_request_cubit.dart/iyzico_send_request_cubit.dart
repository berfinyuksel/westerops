import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_send_request_repository.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../generic_state/generic_state.dart';

class SendRequestCubit extends Cubit<GenericState> {
  final SendRequestRepository _sendRequestRepository;
  SendRequestCubit(this._sendRequestRepository) : super(GenericInitial());

  Future<void> initialValue() async {
    try {
      emit(GenericLoading());
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> sendRequest({required String conversationId}) async {
    try {
      emit(GenericLoading());
      final response = await _sendRequestRepository.sendRequest(conversationId);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

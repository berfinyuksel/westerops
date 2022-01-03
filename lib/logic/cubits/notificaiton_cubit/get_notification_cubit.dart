import 'package:dongu_mobile/data/repositories/get_notification_repository.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetNotificationCubit extends Cubit<GenericState> {
  final GetNotificationRepository _getNotificationRepository;
  GetNotificationCubit(this._getNotificationRepository) : super(GenericInitial());


  Future<void> getNotification() async {
    try {
      emit(GenericLoading());
      final response = await _getNotificationRepository.getNotification();
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

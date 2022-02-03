
import 'package:dongu_mobile/data/repositories/put_notification_repository.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PutNotificationCubit extends Cubit<GenericState> {
  final PutNotificationRepository _getNotificationRepository;
  PutNotificationCubit(this._getNotificationRepository)
      : super(GenericInitial());

  Future<void> putNotification(String notificationId) async {
    try {
      emit(GenericLoading());
      final response = await _getNotificationRepository.putNotification(notificationId);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

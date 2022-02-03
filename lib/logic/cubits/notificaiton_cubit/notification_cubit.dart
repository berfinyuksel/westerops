import 'package:dongu_mobile/data/repositories/notification_repository.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<GenericState> {
  final NotificationRepository _notificationRepository;
  NotificationCubit(this._notificationRepository) : super(GenericInitial());


  Future<void> postNotification(String registrationId, String type) async {
    try {
      emit(GenericLoading());
      final response = await _notificationRepository.postNotification(registrationId, type);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

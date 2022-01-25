import 'package:dongu_mobile/data/repositories/bulk_update_notifications_repository.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BulkUpdateNotificationCubit extends Cubit<GenericState> {
  final BulkUpdateNotificationRepository _bulkUpdateNotificationRepository;
  BulkUpdateNotificationCubit(this._bulkUpdateNotificationRepository)
      : super(GenericInitial());

  Future<void> putNotification(String notificationId) async {
    try {
      emit(GenericLoading());
      final response =
          await _bulkUpdateNotificationRepository.bulkUpdateNotification(notificationId);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

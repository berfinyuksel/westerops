import 'package:dongu_mobile/data/repositories/store_courier_hours_repository.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class StoreCourierCubit extends Cubit<GenericState> {
  final StoreCourierHoursRepository _storeCourierHoursRepository;
  StoreCourierCubit(this._storeCourierHoursRepository)
      : super(GenericInitial());

  Future<void> getCourierHours(int storeId) async {
    try {
      emit(GenericLoading());
      final response =
          await _storeCourierHoursRepository.getCourierHours(storeId);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> getSearchStore(
      bool isAvailable, int storeId, int courierHourId) async {
    try {
      emit(GenericLoading());
      final response = await _storeCourierHoursRepository.updateCourierHours(
        isAvailable,
        storeId,
        courierHourId,
      );
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

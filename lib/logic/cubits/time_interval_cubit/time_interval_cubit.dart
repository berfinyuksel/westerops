import '../../../data/repositories/time_interval_repository.dart';
import '../generic_state/generic_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TimeIntervalCubit extends Cubit<GenericState> {
  final TimeIntervalRepository _timeIntervalRepository;
  TimeIntervalCubit(this._timeIntervalRepository) : super(GenericInitial());

  Future<void> getTimeInterval(int storeId) async {
    try {
      emit(GenericLoading());
      final response = await _timeIntervalRepository.getTimeInterval(storeId);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

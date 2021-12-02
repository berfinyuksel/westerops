import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/store_boxes_repository.dart';
import '../generic_state/generic_state.dart';

class StoreBoxesCubit extends Cubit<GenericState> {
  final StoreBoxesRepository _storeBoxesRepository;
  StoreBoxesCubit(this._storeBoxesRepository) : super(GenericInitial());

  Future<void> getStoreBoxes(int id) async {
    try {
      emit(GenericLoading());
      final response = await _storeBoxesRepository.getStoreBoxess(id);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

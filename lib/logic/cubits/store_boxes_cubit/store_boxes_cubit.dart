import 'package:dongu_mobile/data/repositories/store_boxes_repository.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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

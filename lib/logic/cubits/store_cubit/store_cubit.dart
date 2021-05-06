import 'package:dongu_mobile/data/repositories/store_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../generic_state/generic_state.dart';

class StoreCubit extends Cubit<GenericState> {
  final StoreRepository _storeRepository;
  StoreCubit(this._storeRepository) : super(GenericInitial());

  Future<void> getStores() async {
    try {
      emit(GenericLoading());
      final response = await _storeRepository.getStores();
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

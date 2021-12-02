import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/search_store_repository.dart';
import '../generic_state/generic_state.dart';

class SearchStoreCubit extends Cubit<GenericState> {
  final SearchStoreRepository _searchStoreRepository;
  SearchStoreCubit(this._searchStoreRepository) : super(GenericInitial());

  Future<void> getSearchStore() async {
    try {
      emit(GenericLoading());
  
      final response = await _searchStoreRepository.getSearchStores();
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

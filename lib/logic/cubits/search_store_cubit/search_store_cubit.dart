import 'package:dongu_mobile/data/repositories/search_store_repository.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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

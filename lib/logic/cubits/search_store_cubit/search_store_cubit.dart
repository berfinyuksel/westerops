import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import '../../../data/repositories/search_store_repository.dart';
import '../generic_state/generic_state.dart';

class SearchStoreCubit extends Cubit<GenericState> {
  final SampleSearchStoreRepository _searchStoreRepository;
  String? categoryName;
  SearchStoreCubit(this._searchStoreRepository) : super(GenericInitial());
  List<SearchStore> searchStores = [];
  List<String> popularSearchesList = [];
  Future<void> getSearchStore() async {
    try {
      final response = await _searchStoreRepository.getSearchStores();
      searchStores = response;
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> getSearches(String query) async {
    try {
      emit(GenericLoading());
      final response = await _searchStoreRepository.getSearches(query.toLowerCase());
      print('get searches response is: ' + response.length.toString());
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  void getPopulerSearchesList() {
    popularSearchesList.clear();
    searchStores.forEach((store) {
      store.storeMeals!.forEach((meal) {
        popularSearchesList.add(meal.name!);
      });
    });
  }
}

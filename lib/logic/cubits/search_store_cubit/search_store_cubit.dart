import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import '../../../data/repositories/search_store_repository.dart';
import '../../../data/shared/shared_prefs.dart';
import '../generic_state/generic_state.dart';

class SearchStoreCubit extends Cubit<GenericState> {
  final SampleSearchStoreRepository _searchStoreRepository;
  String? categoryName;
  SearchStoreCubit(this._searchStoreRepository) : super(GenericInitial());
  List<SearchStore> searchStores = [];
  List<SearchStore> searchQueryResults = [];
  List<String> popularSearchesList = [];
  List<SearchStore> deliveredRestaurant = [];
  Future<void> getSearchStore() async {
    try {
      final response = await _searchStoreRepository.getSearchStores();
      searchStores = response;
      //emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> getSearchStoreAddress() async {
    try {
      final response = await _searchStoreRepository.getSearchStores();
      searchStores = response;
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> getSearches(String query) async {
    try {
      emit(GenericLoading());
      var response =
          await _searchStoreRepository.getSearches(query.toLowerCase());
      if (response.length == 0) {
        emit(GenericCompleted(searchQueryResults));
        return;
      } else {
        if (searchQueryResults.isEmpty) {
          searchQueryResults.addAll(response);
        } else {
          List<int> resultsToDelete = [];
          for (var query in searchQueryResults) {
            for (var item in response) {
              if (query.id == item.id) {
                resultsToDelete.add(item.id!);
              }
            }
          }
          searchQueryResults.addAll(response);
          resultsToDelete.forEach((result) {
            searchQueryResults.remove(searchQueryResults
                .firstWhere((element) => element.id == result));
          });
          resultsToDelete.clear();
        }
      }
      emit(GenericCompleted(searchQueryResults));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  void clearSearchQuery() async {
    try {
      searchQueryResults.clear();
      emit(GenericCompleted(searchQueryResults));
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

  getDeliveredRestaurant() {
    // List<SearchStore> restaurants = [];

    int? restaurantId = SharedPrefs.getDeliveredRestaurantAddressId;

    for (var i = 0; i < searchStores.length; i++) {
      if (searchStores[i].id == restaurantId) {
        deliveredRestaurant.add(searchStores[i]);
        print("delivered rest: $deliveredRestaurant");
      }
    }
    emit(GenericCompleted(deliveredRestaurant));
  }
}

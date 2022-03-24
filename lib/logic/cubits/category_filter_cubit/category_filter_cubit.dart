import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/search_store.dart';
import '../../../data/repositories/filters_repository.dart';
import '../../../utils/network_error.dart';

part 'category_filter_state.dart';

class CategoryFilterCubit extends Cubit<CategoryFilterState> {
   final SampleFiltersRepository _filtersRepository;
     List<SearchStore> filterCategories = [];
  CategoryFilterCubit(
    this._filtersRepository,
  ) : super(FilterCategoriesInitial());

   Future<void> getCategoriesQuery(String query) async {
    try {
      emit(FilterCategoriesLoading());
      print("GET CATEGORIES");
      final response = await _filtersRepository.getPackageCategory(query);
      filterCategories = response;
      print(response.length);
      emit(FilterCategoriesCompleted(response: response));
    } on NetworkError catch (e) {
      emit(FilterCategoriesError(e.message + e.statusCode));
    }
  }
}

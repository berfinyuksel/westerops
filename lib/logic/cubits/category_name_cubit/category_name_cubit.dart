import 'package:dongu_mobile/data/repositories/filters_repository.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/category_name.dart';
import '../../../data/model/search_store.dart';
import '../../../data/repositories/category_name_repository.dart';
import '../../../data/services/locator.dart';
import '../search_store_cubit/search_store_cubit.dart';
part 'category_name_state.dart';

class CategoryNameCubit extends Cubit<CategoryNameState> {
  final SampleCategoryNameRepository _categoryNameRepository;
  final SampleFiltersRepository _filtersRepository;
  CategoryNameCubit(this._categoryNameRepository, this._filtersRepository)
      : super(CategoryNameInital());
  List<SearchStore> filterCategories = [];
  List<Result> resultCategories = [];
  init() async {
    await getCategories();
    await sl<SearchStoreCubit>().getSearchStore();
  }

  Future<void> getCategories() async {
    try {
      emit(CategoryNameLoading());

      final response = await _categoryNameRepository.getCategories();
      resultCategories = response;
      print(response.length);
      emit(CategoryNameCompleted(response: response));
    } on NetworkError catch (e) {
      // emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> getCategoriesQuery(String query) async {
    try {
      emit(FilterCategoriesLoading());
      print("GET CATEGORIES");
      final response = await _filtersRepository.getPackageCategory(query);
      filterCategories = response;
      print(response.length);
      emit(FilterCategoriesCompleted(response: response));
    } on NetworkError catch (e) {
      //emit(GenericError(e.message, e.statusCode));
    }
  }
}

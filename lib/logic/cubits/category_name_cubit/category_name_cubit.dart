import 'package:dongu_mobile/utils/network_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/category_name.dart';
import '../../../data/repositories/category_name_repository.dart';

part 'category_name_state.dart';

class CategoryNameCubit extends Cubit<CategoryNameState> {
  final SampleCategoryNameRepository _categoryNameRepository;
  CategoryNameCubit(this._categoryNameRepository) : super(CategoryNameInital());
  List<Result> resultCategories = [];
  init() async {
    await getCategories();
  }

  Future<void> getCategories() async {
    try {
      emit(CategoryNameLoading());

      final response = await _categoryNameRepository.getCategories();
      resultCategories = response;
      print(response.length);
      emit(CategoryNameCompleted(response: response));
    } on NetworkError catch (e){
       emit(CategoryNameError(e.message + e.statusCode));
    }
  }
}

import 'package:dongu_mobile/utils/network_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/category_name_repository.dart';
import '../generic_state/generic_state.dart';

class CategoryNameCubit extends Cubit<GenericState> {
  final CategoryNameRepository _categoryNameRepository;
  CategoryNameCubit(this._categoryNameRepository) : super(GenericInitial());

  Future<void> getCategories() async {
    try {
      emit(GenericLoading());
      final response = await _categoryNameRepository.getCategories();
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

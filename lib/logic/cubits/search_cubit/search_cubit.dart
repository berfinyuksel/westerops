import '../../../data/repositories/search_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../generic_state/generic_state.dart';
import 'package:dongu_mobile/utils/network_error.dart';
class SearchCubit extends Cubit<GenericState> {
  final SampleSearchRepository _searchRepository;
  SearchCubit(this._searchRepository) : super(GenericInitial());

  Future<void> getSearches(String query) async {
    try {
      emit(GenericLoading());
      final response = await _searchRepository.getSearches(query);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

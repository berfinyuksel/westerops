import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/search_location_repository.dart';
import '../generic_state/generic_state.dart';

class SearchLocationCubit extends Cubit<GenericState> {
  final SearchLocationRepository _searchLocationRepository;
  SearchLocationCubit(this._searchLocationRepository) : super(GenericInitial());

  Future<void> getLocations(String search) async {
    try {
      emit(GenericLoading());
      final response = await _searchLocationRepository.getLocations(search);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

import 'package:dongu_mobile/data/repositories/filters_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../generic_state/generic_state.dart';

class FiltersManagerCubit extends Cubit<GenericState> {
  final FiltersRepository _filtersRepository;
  FiltersManagerCubit(this._filtersRepository) : super(GenericInitial());

  Future<void> getPackagePrice(int minPrice, int maxPrice) async {
    try {
      emit(GenericLoading());
      final response = await _filtersRepository.getPackagePrice(minPrice, maxPrice);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode)); 
    }
  }
    Future<void> getPackageDelivery(bool ca) async {
    try {
      emit(GenericLoading());
      final response =
          await _filtersRepository.getPackageDelivery(ca);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
      Future<void> getPackageCategory(String category) async {
    try {
      emit(GenericLoading());
      final response = await _filtersRepository.getPackageCategory(category);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

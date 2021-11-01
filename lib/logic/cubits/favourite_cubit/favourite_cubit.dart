import 'package:dongu_mobile/data/repositories/favourite_repository.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<GenericState> {
  final FavoriteRepository _favoriteRepository;
  FavoriteCubit(this._favoriteRepository) : super(GenericInitial());

  Future<void> deleteFavorite(int? id) async {
    try {
      emit(GenericLoading());
      final response = await _favoriteRepository.deleteFavorite(id);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> addFavorite(int? id) async {
    try {
      emit(GenericLoading());
      final response = await _favoriteRepository.addFavorite(id);
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }

  Future<void> getFavorite() async {
    try {
      emit(GenericLoading());
      final response = await _favoriteRepository.getFavorites();
      emit(GenericCompleted(response));
    } on NetworkError catch (e) {
      emit(GenericError(e.message, e.statusCode));
    }
  }
}

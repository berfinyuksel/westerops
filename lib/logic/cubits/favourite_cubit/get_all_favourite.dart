import '../../../data/repositories/favourite_repository.dart';
import '../generic_state/generic_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllFavoriteCubit extends Cubit<GenericState> {
  final FavoriteRepository _favoriteRepository;
  AllFavoriteCubit(this._favoriteRepository) : super(GenericInitial());

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

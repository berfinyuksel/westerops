import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';

import '../../../data/repositories/favourite_repository.dart';
import '../generic_state/generic_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<GenericState> {
  final FavoriteRepository _favoriteRepository;
  FavoriteCubit(this._favoriteRepository) : super(GenericInitial());

  bool isFavorite = false;
  List<String>? favouritedRestaurants = SharedPrefs.getFavorites;
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

  bool toggleIsFavorite(BuildContext context, SearchStore restaurant) {
    if (isFavorite) {
      deleteFavorite(restaurant.id);
      favouritedRestaurants!.remove(restaurant.id.toString());
      SharedPrefs.setFavoriteIdList(favouritedRestaurants!);
    } else {
      addFavorite(restaurant.id!);
      favouritedRestaurants!.add(restaurant.id.toString());
      SharedPrefs.setFavoriteIdList(favouritedRestaurants!);
    }

    isFavorite = !isFavorite;
    return isFavorite;
    //  context.read<AllFavoriteCubit>().getFavorite();
  }
}

import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/utils/network_error.dart';
import 'package:flutter/material.dart';

import '../../../data/model/favourite.dart';
import '../../../data/repositories/favourite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final SampleFavoriteRepository _favoriteRepository;
  FavoriteCubit(this._favoriteRepository) : super(FavoriteInitial());

  bool isFavorite = false;
  List<Favourite> favoriteRestaurants = [];
  List<String>? favouritedRestaurants = SharedPrefs.getFavorites;

  init(int restaurantID) async {
    await getFavorite();
    setFavorite(restaurantID);
  }

  Future<void> deleteFavorite(int? id) async {
    try {
      await _favoriteRepository.deleteFavorite(id);
    } on NetworkError catch (e) {
      emit(FavoriteError(e.message, e.statusCode));
    }
  }

  Future<void> addFavorite(int? id) async {
    try {
      _favoriteRepository.addFavorite(id);
    } on NetworkError catch (e) {
      emit(FavoriteError(e.message, e.statusCode));
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
    emit(IsFavoriteChange(isFavorite));
    return isFavorite;
    //  context.read<AllFavoriteCubit>().getFavorite();
  }

  //  for (var i = 0; i < stateOfFavorites.response.length; i++) {
  //               if (stateOfFavorites.response[i].id == widget.restaurant!.id) {
  //                 isFavorite = true;
  //               } else if (stateOfFavorites.response[i].id == null) {
  //                 isFavorite = false;
  //               }
  //             }
  Future<void> getFavorite() async {
    try {
      emit(FavoriteLoading());
      final response = await _favoriteRepository.getFavorites();
      favoriteRestaurants = response;
     // print("get favorites results: ${response.first.id}");
      emit(FavoriteCompleted(response));
    } on NetworkError catch (e) {
      emit(FavoriteError(e.message, e.statusCode));
    }
  }

  void setFavorite(int restaurantID) {
    favoriteRestaurants.forEach((restoran) {
      restoran.id == restaurantID ? isFavorite = true : isFavorite = false;
    });
    emit(IsFavoriteChange(isFavorite));
    print("isfavorite is :" + isFavorite.toString());
  }
}

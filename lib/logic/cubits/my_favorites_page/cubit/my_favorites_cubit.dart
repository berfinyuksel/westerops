import 'package:bloc/bloc.dart';
import 'package:dongu_mobile/data/model/favourite.dart';
import 'package:dongu_mobile/data/model/search_store.dart';
import 'package:dongu_mobile/data/repositories/favourite_repository.dart';
import 'package:dongu_mobile/data/repositories/search_store_repository.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';

part 'my_favorites_state.dart';

class MyFavoritesCubit extends Cubit<MyFavoritesState> {
  MyFavoritesCubit() : super(MyFavoritesState());

  init() async {
    startLoading();
    getStores();
    stopLoading();
  }

  getStores() async {
    List<SearchStore> favouriteRestaurants = [];
    List<String> favoriteListForShared = [];
    List<Favourite> favorites = [];
    List<SearchStore> searchStores = [];

    favorites = await sl<SampleFavoriteRepository>().getFavorites();
    searchStores = await sl<SampleSearchStoreRepository>().getSearchStores();

    for (var i = 0; i < searchStores.length; i++) {
      for (var j = 0; j < favorites.length; j++) {
        if (searchStores[i].id == favorites[j].id) {
          favouriteRestaurants.add(searchStores[i]);
          favoriteListForShared.add(searchStores[i].id.toString());
        }
      }
    }

    SharedPrefs.setFavoriteIdList(favoriteListForShared);
    
    emit(
      state.copyWith(
        favoritedRestaurants: favouriteRestaurants,
      ),
    );
  }

  void startLoading() {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
  }

  void stopLoading() {
    emit(
      state.copyWith(
        isLoading: false,
      ),
    );
  }

  void hideBottomInfo() {
    emit(
      state.copyWith(
        isShowBottomInfo: false,
      ),
    );
  }

  void toggleBottomInfo() {
    emit(
      state.copyWith(
        isShowBottomInfo: !state.isShowBottomInfo,
      ),
    );
  }

  void setSelectedIndex(int i) {
    emit(
      state.copyWith(
        selectedIndex: i,
      ),
    );
  }

  void toogleShowOnMap() {
    emit(
      state.copyWith(
        isShowOnMap: !state.isShowOnMap,
      ),
    );
  }
}

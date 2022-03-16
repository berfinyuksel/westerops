part of 'my_favorites_cubit.dart';

class MyFavoritesState {
  final bool isShowOnMap;
  final bool isShowBottomInfo;
  final int selectedIndex;
  final List<SearchStore>? favoritedRestaurants;
  final bool isLoading;

  MyFavoritesState({
    this.isShowOnMap = false,
    this.isShowBottomInfo = false,
    this.selectedIndex = 0,
    this.favoritedRestaurants, 
    this.isLoading =false,
  });

  MyFavoritesState copyWith({
    bool? isShowOnMap,
    bool? isShowBottomInfo,
    int? selectedIndex,
    List<SearchStore>? favoritedRestaurants,
    bool? isLoading,
  }) {
    return MyFavoritesState(
      isShowOnMap: isShowOnMap ?? this.isShowOnMap,
      isShowBottomInfo: isShowBottomInfo ?? this.isShowBottomInfo,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      favoritedRestaurants: favoritedRestaurants,
      isLoading: isLoading ?? false,
    );
  }
}

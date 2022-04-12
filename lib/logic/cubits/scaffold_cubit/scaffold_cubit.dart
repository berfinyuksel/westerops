import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/screens/cart_view/cart_view.dart';
import '../../../presentation/screens/home_page_view/home_page_view.dart';
import '../../../presentation/screens/my_favorites_view/my_favorites_view.dart';
import '../../../presentation/screens/my_notifications_view/my_notifications_view.dart';
import '../../../presentation/screens/search_view/search_view.dart';
import '../../../utils/locale_keys.g.dart';

part 'scaffold_state.dart';

class ScaffoldCubit extends Cubit<ScaffoldState> {
  bool isShowDrawer;
  bool isShowBottomNavBar;
  bool showAppBarBackIcon;
  ScaffoldCubit(
      {this.isShowDrawer = false,
      this.isShowBottomNavBar = false,
      this.showAppBarBackIcon = false})
      : super(ScaffoldInital());

  init() async {}

  int orderBasketCounter(int basketCount) {
    int totalCount = basketCount++;
    return totalCount;
  }

  notificationCounter() {}
  bottomNavBarItem() {
    List<String?> _titles = <String?>[
      LocaleKeys.bottom_nav_bar_item_1,
      LocaleKeys.bottom_nav_bar_item_2,
      LocaleKeys.bottom_nav_bar_item_3,
      LocaleKeys.bottom_nav_bar_item_4,
      LocaleKeys.bottom_nav_bar_item_5,
    ];
    List<Widget> _widgetOptions = <Widget>[
      HomePageView(),
      SearchView(),
      MyFavoritesView(),
      MyNotificationsView(),
      CartView(),
    ];
  }
}

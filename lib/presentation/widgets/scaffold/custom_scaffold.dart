import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import 'package:dongu_mobile/presentation/screens/my_notifications_view/my_notifications_view.dart';
import 'package:dongu_mobile/presentation/screens/search_view/search_demo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../screens/cart_view/cart_view.dart';
import '../../screens/home_page_view/home_page_view.dart';
import '../../screens/my_favorites_view/my_favorites_view.dart';
import '../../screens/search_view/search.dart';
import 'components/custom_drawer.dart';
import '../text/locale_text.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../utils/extensions/string_extension.dart';

class CustomScaffold extends StatefulWidget {
  String? title;
  Widget? body;
  bool? isDrawer;
  bool? isNavBar;
  CustomScaffold({
    Key? key,
    this.title,
    this.body,
    this.isNavBar,
    this.isDrawer,
  }) : super(key: key);
  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  bool homePageActiveIcon = true;
  List<Widget> _widgetOptions = <Widget>[
    HomePageView(),
    SearchViewDemo(),
    MyFavoritesView(),
    MyNotificationsView(),
    CartView(),
  ];
  List<String?> _titles = <String?>[
    LocaleKeys.bottom_nav_bar_item_1,
    LocaleKeys.bottom_nav_bar_item_2,
    LocaleKeys.bottom_nav_bar_item_3,
    LocaleKeys.bottom_nav_bar_item_4,
    LocaleKeys.bottom_nav_bar_item_5,
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.body = null;
      widget.title = null;
      widget.isDrawer = false;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: widget.isDrawer == null
          ? widget.title == null
              ? _titles.elementAt(_selectedIndex) == null
                  ? null
                  : buildAppBarWithTitleList()
              : buildAppBarWithInputTitle()
          : widget.isDrawer!
              ? buildAppBarForDrawer()
              : widget.title == null
                  ? _titles.elementAt(_selectedIndex) == null
                      ? null
                      : buildAppBarWithTitleList()
                  : buildAppBarWithInputTitle(),
      endDrawer: widget.isDrawer == null
          ? CustomDrawer()
          : widget.isDrawer!
              ? null
              : CustomDrawer(),
      bottomNavigationBar: widget.isNavBar != null
          ? null
          : ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(18.0),
              ),
              child: buildBottomNavigationBar()),
      body: widget.body == null
          ? _widgetOptions.elementAt(_selectedIndex)
          : widget.body,
    );
  }

  AppBar buildAppBarForDrawer() {
    return AppBar(
      iconTheme: IconThemeData(color: AppColors.greenColor, size: 20.0),
      elevation: 0,
      bottomOpacity: 0,
      leading: IconButton(
        icon: SvgPicture.asset(ImageConstant.BACK_ICON),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: LocaleText(
        text: LocaleKeys.custom_drawer_title,
        style: AppTextStyles.appBarTitleStyle,
      ),
      centerTitle: true,
    );
  }

  AppBar buildAppBarWithInputTitle() {
    return AppBar(
      actions: [
        Padding(
          padding: EdgeInsets.only(right: context.dynamicWidht(0.03)),
          child: IconButton(
            icon: SvgPicture.asset(ImageConstant.COMMONS_DRAWER_ICON),
            onPressed: () {
              setState(() {
                homePageActiveIcon = false;
              });
              return scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ),
      ],
      iconTheme: IconThemeData(color: AppColors.greenColor, size: 20.0),
      elevation: 0,
      bottomOpacity: 0,
      leading: IconButton(
        icon: SvgPicture.asset(ImageConstant.BACK_ICON),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: LocaleText(
        text: widget.title!,
        style: AppTextStyles.appBarTitleStyle,
      ),
      centerTitle: true,
    );
  }

  AppBar buildAppBarWithTitleList() {
    return AppBar(
      elevation: 0,
      bottomOpacity: 0,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: context.dynamicWidht(0.03)),
          child: IconButton(
              icon: SvgPicture.asset(ImageConstant.COMMONS_DRAWER_ICON),
              onPressed: () {
                setState(() {
                  homePageActiveIcon = false;
                });
                return scaffoldKey.currentState!.openEndDrawer();
              }),
        ),
      ],
      iconTheme: IconThemeData(color: AppColors.greenColor),
      leading: _selectedIndex == 2 || _selectedIndex == 3 || _selectedIndex == 4
          ? IconButton(
              icon: SvgPicture.asset(ImageConstant.BACK_ICON),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            )
          : Text(""),
      title: _selectedIndex == 1 ||
              _selectedIndex == 2 ||
              _selectedIndex == 3 ||
              _selectedIndex == 4
          ? LocaleText(
              text: _titles.elementAt(_selectedIndex)!,
              style: AppTextStyles.appBarTitleStyle,
            )
          : SvgPicture.asset(ImageConstant.COMMONS_APP_BAR_LOGO),
      // title: SvgPicture.asset(ImageConstant.COMMONS_APP_BAR_LOGO),
      centerTitle: true,
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageConstant.NAVBAR_HOME,
            ),
            activeIcon: SvgPicture.asset(
              ImageConstant.NAVBAR_HOME_ACTIVE,
            ),
            label: LocaleKeys.bottom_nav_bar_item_1.locale,
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(ImageConstant.NAVBAR_SEARCH),
          activeIcon: SvgPicture.asset(
            ImageConstant.NAVBAR_SEARCH_ACTIVE,
          ),
          label: LocaleKeys.bottom_nav_bar_item_2.locale,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ImageConstant.NAVBAR_FAVORITES,
          ),
          activeIcon: SvgPicture.asset(ImageConstant.NAVBAR_FAVORITES_ACTIVE),
          label: LocaleKeys.bottom_nav_bar_item_3.locale,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ImageConstant.NAVBAR_NOTIFACATIONS,
          ),
          activeIcon: SvgPicture.asset(
            ImageConstant.NAVBAR_NOTIFACATIONS_ACTIVE,
          ),
          label: LocaleKeys.bottom_nav_bar_item_4.locale,
        ),
        BottomNavigationBarItem(
          icon: Stack(
            alignment: Alignment.topRight,
            children: [
              SvgPicture.asset(
                ImageConstant.NAVBAR_BASKET,
              ),
              Builder(builder: (context) {
                final counterState = context.watch<BasketCounterCubit>().state;

                return Visibility(
                  visible: counterState > 0,
                  child: Container(
                    height: 14,
                    width: 14,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.orangeColor),
                    child: Text(
                      counterState.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.7),
                    ),
                  ),
                );
              }),
            ],
          ),
          activeIcon: Stack(
            alignment: Alignment.topRight,
            children: [
              SvgPicture.asset(
                ImageConstant.NAVBAR_BASKET_ACTIVE,
              ),
              Builder(builder: (context) {
                final counterState = context.watch<BasketCounterCubit>().state;

                return Visibility(
                  visible: counterState > 0,
                  child: Container(
                    height: 14,
                    width: 14,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.orangeColor),
                    child: Text(
                      counterState.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10.7),
                    ),
                  ),
                );
              }),
            ],
          ),
          label: LocaleKeys.bottom_nav_bar_item_5.locale,
        ),
      ],
      showUnselectedLabels: true,
      currentIndex: _selectedIndex,
      backgroundColor: Colors.white,
      unselectedItemColor: AppColors.textColor,
      unselectedLabelStyle: AppTextStyles.subTitleStyle,
      selectedLabelStyle: AppTextStyles.subTitleStyle,
      onTap: _onItemTapped,
    );
  }
}

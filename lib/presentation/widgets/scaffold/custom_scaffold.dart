import 'package:dongu_mobile/presentation/widgets/scaffold/components/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';

class CustomScaffold extends StatefulWidget {
  String? title;
  Widget? body;
  CustomScaffold({
    Key? key,
    this.title,
    this.body,
  }) : super(key: key);
  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    //buraya ekranlar gelcek
    Text("Anasayfa"),
    Text("Arama"),
    Text("Favorilerim"),
    Text("Bildirimlerim"),
    Text("Sepetim"),
  ];
  List<String?> _titles = <String?>[
    "Anasayfa",
    "Arama",
    "Favorilerim",
    "Bildirimlerim",
    "Sepetim",
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.body = null;
      widget.title = null;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: widget.title == null
          ? _titles.elementAt(_selectedIndex) == null
              ? null
              : buildAppBarWithTitleList()
          : buildAppBarWithInputTitle(),
      endDrawer: CustomDrawer(),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: widget.body == null ? _widgetOptions.elementAt(_selectedIndex) : widget.body,
    );
  }

  AppBar buildAppBarWithInputTitle() {
    return AppBar(
      iconTheme: IconThemeData(color: AppColors.greenColor),
      title: Text(
        widget.title!,
        style: AppTextStyles.appBarTitleStyle,
      ),
      centerTitle: true,
    );
  }

  AppBar buildAppBarWithTitleList() {
    return AppBar(
      iconTheme: IconThemeData(color: AppColors.greenColor),
      leading: Container(),
      title: Text(
        _titles.elementAt(_selectedIndex)!,
        style: AppTextStyles.appBarTitleStyle,
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ImageConstant.NAVBAR_HOME,
          ),
          activeIcon: SvgPicture.asset(
            ImageConstant.NAVBAR_HOME_ACTIVE,
          ),
          label: "Anasayfa",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(ImageConstant.NAVBAR_SEARCH),
          activeIcon: SvgPicture.asset(
            ImageConstant.NAVBAR_SEARCH_ACTIVE,
          ),
          label: "Arama",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ImageConstant.NAVBAR_FAVORITES,
          ),
          activeIcon: SvgPicture.asset(ImageConstant.NAVBAR_FAVORITES_ACTIVE),
          label: "Favorilerim",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ImageConstant.NAVBAR_NOTIFACATIONS,
          ),
          activeIcon: SvgPicture.asset(
            ImageConstant.NAVBAR_NOTIFACATIONS_ACTIVE,
          ),
          label: "Bildirimlerim",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            ImageConstant.NAVBAR_BASKET,
          ),
          activeIcon: SvgPicture.asset(
            ImageConstant.NAVBAR_BASKET_ACTIVE,
          ),
          label: "Sepetim",
        ),
      ],
      showUnselectedLabels: true,
      currentIndex: _selectedIndex,
      unselectedItemColor: AppColors.textColor,
      unselectedLabelStyle: AppTextStyles.subTitleStyle,
      selectedLabelStyle: AppTextStyles.subTitleStyle,
      onTap: _onItemTapped,
    );
  }
}

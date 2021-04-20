import 'components/special_for_me_list_tile_builder.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/extensions/string_extension.dart';

import 'components/all_list_tile_builder.dart';
import 'components/my_orders_list_tile_builder.dart';

class MyNotificationsView extends StatefulWidget {
  MyNotificationsView({Key? key}) : super(key: key);

  @override
  _MyNotificationsViewState createState() => _MyNotificationsViewState();
}

class _MyNotificationsViewState extends State<MyNotificationsView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Bildirimlerim",
      body: Column(
        children: [
          tabBarPadding(context),
          Expanded(
            child: TabBarView(controller: _controller, children: [
              Column(
                children: [MyOrdersListTileBuilder()],
              ),
              Column(
                children: [AllListTileBuilder()],
              ),
              Column(
                children: [SpecialForMeListTileBuilder()],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Padding tabBarPadding(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: context.dynamicWidht(0.065),
          right: context.dynamicWidht(0.065),
          top: context.dynamicHeight(0.028)),
      child: tabBarContainer(context),
    );
  }

  Container tabBarContainer(BuildContext context) {
    return Container(
      width: context.dynamicWidht(0.87),
      height: context.dynamicHeight(0.071),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18.0),
          bottom: Radius.circular(8.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // SizedBox(height: 3,),
          tabBar(context),
          Spacer(
            flex: 1,
          ),
          Divider(
            thickness: 2,
            height: 0,
            color: AppColors.borderAndDividerColor,
          ),
        ],
      ),
    );
  }

  TabBar tabBar(BuildContext context) {
    return TabBar(
        labelPadding:
            EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.05)),
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: AppColors.orangeColor),
            insets:
                EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.060))),
        labelColor: AppColors.orangeColor,
        labelStyle: AppTextStyles.bodyTitleStyle,
        unselectedLabelColor: AppColors.textColor,
        unselectedLabelStyle: GoogleFonts.montserrat(
          decoration: TextDecoration.none,
          fontSize: 16.0,
          color: AppColors.textColor,
          fontWeight: FontWeight.w300,
          height: 1.5,
        ),
        indicatorColor: AppColors.orangeColor,
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(text: LocaleKeys.my_notifications_tab_bar_title_title1.locale),
          Tab(
            text: LocaleKeys.my_notifications_tab_bar_title_title2.locale,
          ),
          Tab(
            text: LocaleKeys.my_notifications_tab_bar_title_title3.locale,
          ),
        ]);
  }
}

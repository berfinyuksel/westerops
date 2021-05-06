import 'package:flutter/material.dart';

import '../../../../utils/constants/route_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../button/custom_button.dart';
import '../custom_scaffold.dart';
import 'drawer_body_title.dart';
import 'drawer_list_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      child: Drawer(
        child: CustomScaffold(
          isDrawer: true,
          title: LocaleKeys.custom_drawer_title,
          body: Container(
            color: AppColors.scaffoldBackgroundColor,
            child: ListView(
              padding: EdgeInsets.only(bottom: context.dynamicHeight(0.05)),
              children: <Widget>[
                SizedBox(
                  height: context.dynamicHeight(0.03),
                ),
                Padding(
                  padding: EdgeInsets.only(left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
                  child: Row(
                    children: [
                      CustomButton(
                        width: context.dynamicWidht(0.4),
                        title: LocaleKeys.custom_drawer_login_button,
                        textColor: AppColors.greenColor,
                        color: Colors.transparent,
                        borderColor: AppColors.greenColor,
                        onPressed: () {
                          Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW);
                        },
                      ),
                      Spacer(flex: 1),
                      CustomButton(
                        width: context.dynamicWidht(0.4),
                        title: LocaleKeys.custom_drawer_register_button,
                        textColor: Colors.white,
                        color: AppColors.greenColor,
                        borderColor: AppColors.greenColor,
                        onPressed: () {
                          Navigator.pushNamed(context, RouteConstant.REGISTER_VIEW);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.03),
                ),
                DrawerListTile(
                    title: LocaleKeys.custom_drawer_body_list_tile_inform,
                    onTap: () {
                      Navigator.pushNamed(context, RouteConstant.MY_INFORMATION_VIEW);
                    }),
                DrawerListTile(
                  title: LocaleKeys.custom_drawer_body_list_tile_past_orders,
                  onTap: () {
                    Navigator.pushNamed(context, RouteConstant.PAST_ORDER_VIEW);
                  },
                ),
                DrawerListTile(
                  title: LocaleKeys.custom_drawer_body_list_tile_adresses,
                  onTap: () {
                    Navigator.pushNamed(context, RouteConstant.ADDRESS_VIEW);
                  },
                ),
                DrawerListTile(
                  title: LocaleKeys.custom_drawer_body_list_tile_cards,
                ),
                SizedBox(
                  height: context.dynamicHeight(0.03),
                ),
                DrawerBodyTitle(
                  text: LocaleKeys.custom_drawer_body_title_1,
                ),
                SizedBox(
                  height: context.dynamicHeight(0.02),
                ),
                DrawerListTile(
                  title: LocaleKeys.custom_drawer_body_list_tile_general_settings,
                  onTap: () {
                    Navigator.pushNamed(context, RouteConstant.GENERAL_SETTINGS_VIEW);
                  },
                ),
                DrawerListTile(
                  title: LocaleKeys.custom_drawer_body_list_tile_language_settings,
                  onTap: () {
                    Navigator.pushNamed(context, RouteConstant.LANGUAGE_SETTINGS_VIEW);
                  },
                ),
                DrawerListTile(
                  title: LocaleKeys.custom_drawer_body_list_tile_change_location,
                  onTap: () {
                    Navigator.pushNamed(context, RouteConstant.CHANGE_LOCATION_VIEW);
                  },
                ),
                DrawerListTile(
                  title: LocaleKeys.custom_drawer_body_list_tile_rate_app,
                ),
                SizedBox(
                  height: context.dynamicHeight(0.03),
                ),
                DrawerBodyTitle(
                  text: LocaleKeys.custom_drawer_body_title_2,
                ),
                SizedBox(
                  height: context.dynamicHeight(0.02),
                ),
                DrawerListTile(
                  title: LocaleKeys.custom_drawer_body_list_tile_about_app,
                  onTap: () {
                    Navigator.pushNamed(context, RouteConstant.ABOUT_APP_VIEW);
                  },
                ),
                DrawerListTile(
                  title: LocaleKeys.custom_drawer_body_list_tile_about_food_waste,
                  onTap: () {
                    Navigator.pushNamed(context, RouteConstant.FOOD_WASTE_VIEW);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

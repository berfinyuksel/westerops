import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/components/drawer_body_title.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/components/drawer_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      child: Drawer(
        child: Container(
          color: AppColors.scaffoldBackgroundColor,
          child: ListView(
            padding: EdgeInsets.only(bottom: context.dynamicHeight(0.1)),
            children: <Widget>[
              AppBar(
                leading: IconButton(
                  icon: SvgPicture.asset(ImageConstant.BACK_ICON),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                title: LocaleText(
                  text: LocaleKeys.custom_drawer_title,
                  alignment: TextAlign.center,
                  style: AppTextStyles.appBarTitleStyle,
                ),
              ),
              SizedBox(
                height: context.dynamicHeight(0.03),
              ),
              Row(
                children: [
                  Spacer(flex: 1),
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
                  Spacer(flex: 1),
                ],
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
              DrawerListTile(
                title: LocaleKeys.custom_drawer_body_list_tile_restaurants,
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
              ),
              DrawerListTile(
                title: LocaleKeys.custom_drawer_body_list_tile_language_settings,
                onTap: () {
                  Navigator.pushNamed(context, RouteConstant.LANGUAGE_SETTINGS_VIEW);
                },
              ),
              DrawerListTile(
                title: LocaleKeys.custom_drawer_body_list_tile_change_location,
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
    );
  }
}

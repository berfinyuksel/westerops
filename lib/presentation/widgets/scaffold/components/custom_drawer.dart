import '../../../../data/services/auth_service.dart';
import '../../../../data/services/facebook_login_controller.dart';
import '../../../../data/shared/shared_prefs.dart';
import '../../../../logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import '../../../../logic/cubits/order_cubit/order_cubit.dart';
import '../../../../logic/cubits/sum_price_order_cubit/sum_price_order_cubit.dart';
import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/route_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../button/custom_button.dart';
import '../custom_scaffold.dart';
import 'drawer_body_title.dart';
import 'drawer_list_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      child: Drawer(
        child: CustomScaffold(
          isDrawer: true,
          title: LocaleKeys.custom_drawer_title,
          body: ListView(
            padding: EdgeInsets.only(bottom: context.dynamicHeight(0.05)),
            children: <Widget>[
              SizedBox(
                height: context.dynamicHeight(0.03),
              ),
              Padding(
                padding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
                child: SharedPrefs.getIsLogined
                    ? buildLoginedProfile(context)
                    : buildAuthButtons(context),
              ),
              SizedBox(
                height: context.dynamicHeight(0.03),
              ),
              DrawerListTile(
                  title: LocaleKeys.custom_drawer_body_list_tile_inform,
                  onTap: () {
                    SharedPrefs.getIsLogined == false
                        ? Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW)
                        : Navigator.pushNamed(
                            context, RouteConstant.MY_INFORMATION_VIEW);
                  }),
              DrawerListTile(
                title: LocaleKeys.custom_drawer_body_list_tile_past_orders,
                onTap: () {
                  SharedPrefs.getIsLogined == false
                      ? Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW)
                      : Navigator.pushNamed(
                          context, RouteConstant.PAST_ORDER_VIEW);
                },
              ),
              DrawerListTile(
                title: LocaleKeys.custom_drawer_body_list_tile_adresses,
                onTap: () {
                  SharedPrefs.getIsLogined == false
                      ? Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW)
                      : Navigator.pushNamed(
                          context, RouteConstant.ADDRESS_VIEW);
                },
              ),
              DrawerListTile(
                title: LocaleKeys.custom_drawer_body_list_tile_cards,
                onTap: () {
                  SharedPrefs.getIsLogined == false
                      ? Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW)
                      : Navigator.pushNamed(
                          context, RouteConstant.MY_REGISTERED_CARD_VIEW);
                },
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
                  Navigator.pushNamed(
                      context, RouteConstant.GENERAL_SETTINGS_VIEW);
                },
              ),
              DrawerListTile(
                title:
                    LocaleKeys.custom_drawer_body_list_tile_language_settings,
                onTap: () {
                  Navigator.pushNamed(
                      context, RouteConstant.LANGUAGE_SETTINGS_VIEW);
                },
              ),
              DrawerListTile(
                title: LocaleKeys.custom_drawer_body_list_tile_change_location,
                onTap: () {
                  Navigator.pushNamed(
                      context, RouteConstant.CHANGE_LOCATION_VIEW);
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
              SizedBox(
                height: context.dynamicHeight(0.04),
              ),
              Visibility(
                  visible: SharedPrefs.getIsLogined,
                  child: buildLogoutButton(context)),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.custom_drawer_log_out_button,
        color: Colors.transparent,
        borderColor: AppColors.greenColor,
        textColor: AppColors.greenColor,
        onPressed: () {
          FacebookSignInController().logOut();
          AuthService().logOutFromGmail();
          SharedPrefs.clearCache();
          Navigator.pushReplacementNamed(
              context, RouteConstant.CUSTOM_SCAFFOLD);
          context.read<OrderCubit>().clearBasket();

          SharedPrefs.setSumPrice([]);
          context.read<SumPriceOrderCubit>().sumprice([]);

          SharedPrefs.setCounter(0);
          SharedPrefs.setMenuList([]);
          context.read<BasketCounterCubit>().setCounter(0);

          Navigator.pop(context);
        },
      ),
    );
  }

  Row buildLoginedProfile(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          ImageConstant.COMMONS_PROFILE_ICON,
          height: context.dynamicHeight(0.042),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${SharedPrefs.getUserName} ${SharedPrefs.getUserLastName}",
              style: AppTextStyles.bodyTitleStyle,
            ),
            SizedBox(
              height: context.dynamicHeight(0.008),
            ),
            Container(
              height: context.dynamicHeight(0.004),
              width: context.dynamicWidht(0.78),
              color: AppColors.borderAndDividerColor,
            ),
            SizedBox(
              height: context.dynamicHeight(0.013),
            ),
            Text(
              SharedPrefs.getUserAddress,
              style: AppTextStyles.bodyTextStyle,
            ),
          ],
        )
      ],
    );
  }

  Padding buildAuthButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.dynamicWidht(0.06)),
      child: Row(
        children: [
          CustomButton(
            width: context.dynamicWidht(0.4),
            title: LocaleKeys.custom_drawer_login_button,
            textColor: AppColors.greenColor,
            color: Colors.transparent,
            borderColor: AppColors.greenColor,
            onPressed: () {
              Navigator.pushReplacementNamed(context, RouteConstant.LOGIN_VIEW);
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
    );
  }
}

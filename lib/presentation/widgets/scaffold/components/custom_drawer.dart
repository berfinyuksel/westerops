import 'package:dongu_mobile/logic/cubits/order_bar_cubit/order_bar_cubit.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_old_price_order_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';

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
  final InAppReview inAppReview = InAppReview.instance;
  CustomDrawer({
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
          isNavBar: true,
          title: LocaleKeys.custom_drawer_title,
          body: ListView(
            padding: EdgeInsets.only(bottom: 40.h),
            children: <Widget>[
              SizedBox(
                height: 36.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 28.w),
                child: SharedPrefs.getIsLogined ? buildLoginedProfile(context) : buildAuthButtons(context),
              ),
              SizedBox(
                height: 30.h,
              ),
              DrawerListTile(
                  title: LocaleKeys.custom_drawer_body_list_tile_inform,
                  onTap: () {
                    SharedPrefs.getIsLogined == false
                        ? Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW)
                        : Navigator.pushNamed(context, RouteConstant.MY_INFORMATION_VIEW);
                  }),
              DrawerListTile(
                title: LocaleKeys.custom_drawer_body_list_tile_past_orders,
                onTap: () {
                  SharedPrefs.getIsLogined == false
                      ? Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW)
                      : Navigator.pushNamed(context, RouteConstant.PAST_ORDER_VIEW);
                },
              ),
              DrawerListTile(
                title: LocaleKeys.custom_drawer_body_list_tile_adresses,
                onTap: () {
                  SharedPrefs.getIsLogined == false
                      ? Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW)
                      : Navigator.pushNamed(context, RouteConstant.ADDRESS_VIEW);
                },
              ),
              DrawerListTile(
                title: LocaleKeys.custom_drawer_body_list_tile_cards,
                onTap: () {
                  SharedPrefs.getIsLogined == false
                      ? Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW)
                      : Navigator.pushNamed(context, RouteConstant.MY_REGISTERED_CARD_VIEW);
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              DrawerBodyTitle(
                text: LocaleKeys.custom_drawer_body_title_1,
              ),
              SizedBox(
                height: 12.h,
              ),
              DrawerListTile(
                title: LocaleKeys.custom_drawer_body_list_tile_general_settings,
                onTap: () {
                  Navigator.pushNamed(context, RouteConstant.GENERAL_SETTINGS_VIEW);
                },
              ),
              // DrawerListTile(
              //   title:
              //       LocaleKeys.custom_drawer_body_list_tile_language_settings,
              //   onTap: () {
              //     Navigator.pushNamed(
              //         context, RouteConstant.LANGUAGE_SETTINGS_VIEW);
              //   },
              // ),
              DrawerListTile(
                title: LocaleKeys.custom_drawer_body_list_tile_change_location,
                onTap: () {
                  Navigator.pushNamed(context, RouteConstant.CHANGE_LOCATION_VIEW);
                },
              ),
              DrawerListTile(
                title: LocaleKeys.custom_drawer_body_list_tile_rate_app,
                onTap: () async {
                  if (await inAppReview.isAvailable()) {
                    inAppReview.requestReview();
                  }
                },
              ),
              SizedBox(
                height: 40.h,
              ),
              DrawerBodyTitle(
                text: LocaleKeys.custom_drawer_body_title_2,
              ),
              SizedBox(
                height: 10.h,
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
                height: 40.h,
              ),
              Visibility(visible: SharedPrefs.getIsLogined, child: buildLogoutButton(context)),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.custom_drawer_log_out_button,
        color: Colors.transparent,
        borderColor: AppColors.greenColor,
        textColor: AppColors.greenColor,
        onPressed: () {
          context.read<OrderBarCubit>().stateOfBar(false);
          context.read<OrderCubit>().clearBasket();

          SharedPrefs.setSumPrice(0);
          context.read<SumPriceOrderCubit>().clearPrice();
          SharedPrefs.setOldSumPrice(0);
          context.read<SumOldPriceOrderCubit>().clearOldPrice();

          SharedPrefs.setCounter(0);
          SharedPrefs.setMenuList([]);
          context.read<BasketCounterCubit>().setCounter(0);
          if (SharedPrefs.getIsLogined == false) {
            FacebookSignInController().logOut();
            AuthService().logOutFromGmail();
          }
          // FacebookSignInController().logOut();
          // AuthService().logOutFromGmail();
          SharedPrefs.clearCache();
          Navigator.pushReplacementNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
          //Navigator.pop(context);
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
          height: 39.34.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${SharedPrefs.getUserName}",
              style: AppTextStyles.bodyTitleStyle,
            ),
            SizedBox(
              height: 7.h,
            ),
            Container(
              height: 4.h,
              width: 335.w,
              color: AppColors.borderAndDividerColor,
            ),
            SizedBox(
              height: 12.h,
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
            width: 176.w,
            title: LocaleKeys.custom_drawer_login_button,
            textColor: AppColors.greenColor,
            color: Colors.transparent,
            borderColor: AppColors.greenColor,
            onPressed: () {
              Navigator.pushReplacementNamed(context, RouteConstant.LOGIN_VIEW);
            },
          ),
          SizedBox(width: 20.w),
          CustomButton(
            width: 176.w,
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

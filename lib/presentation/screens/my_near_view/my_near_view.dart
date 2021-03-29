import 'package:dongu_mobile/presentation/screens/my_favorites_view/components/address_text.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MyNearView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.my_near_title,
      body: buildBody(context),
    );
  }

  ListView buildBody(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        buildTitlesAndSearchBar(context),
        buildListViewRestaurantInfo()
      ],
    );
  }

  Padding buildTitlesAndSearchBar(BuildContext context) {
    return Padding(
          padding: EdgeInsets.only(
            left: context.dynamicWidht(0.06),
            right: context.dynamicWidht(0.06),
            top: context.dynamicHeight(0.02),
            bottom: context.dynamicHeight(0.02),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildRowTitleLeftRight(context, LocaleKeys.my_near_location, LocaleKeys.my_near_edit),
              Divider(
                thickness: 4,
                color: AppColors.borderAndDividerColor,
              ),
              AddressText(),
              SizedBox(height: context.dynamicHeight(0.03)),
              Row(
                children: [
                  buildSearchBar(context),
                  Spacer(),
                  SvgPicture.asset(ImageConstant.COMMONS_FILTER_ICON),
                ],
              ),
              SizedBox(height: context.dynamicHeight(0.03)),
              LocaleText(
                text: LocaleKeys.my_near_body_title,
                style: AppTextStyles.bodyTitleStyle,
              ),
              Divider(
                thickness: 4,
                color: AppColors.borderAndDividerColor,
              ),
            ],
          ),
        );
  }

  ListView buildListViewRestaurantInfo() {
    return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return RestaurantInfoListTile(
                restaurantName: "Mini Burger",
                distance: "74m",
                packetNumber: "4 paket",
                availableTime: "18:00-21:00",
              );
            });
  }

  Row buildRowTitleLeftRight(BuildContext context, String titleLeft, String titleRight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocaleText(
          text: titleLeft,
          style: AppTextStyles.bodyTitleStyle,
        ),
        LocaleText(
          text: titleRight,
          style: GoogleFonts.montserrat(
            fontSize: 12.0,
            color: AppColors.orangeColor,
            fontWeight: FontWeight.w600,
            height: 2.0,
          ),
          alignment: TextAlign.right,
        ),
      ],
    );
  }

  Container buildSearchBar(BuildContext context) {
    return Container(
      width: context.dynamicWidht(0.72),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(25.0),
          left: Radius.circular(4.0),
        ),
        color: Colors.white,
      ),
      child: TextFormField(
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.bodyTextStyle,
        decoration: InputDecoration(
            suffixIcon: SvgPicture.asset(
              ImageConstant.COMMONS_SEARCH_ICON,
            ),
            border: buildOutlineInputBorder(),
            focusedBorder: buildOutlineInputBorder(),
            enabledBorder: buildOutlineInputBorder(),
            errorBorder: buildOutlineInputBorder(),
            disabledBorder: buildOutlineInputBorder(),
            contentPadding: EdgeInsets.only(left: context.dynamicWidht(0.046)),
            hintText: "Yemek, restoran ara"),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(25.0),
        left: Radius.circular(4.0),
      ),
      borderSide: BorderSide(
        width: 2.0,
        color: AppColors.borderAndDividerColor,
      ),
    );
  }
}

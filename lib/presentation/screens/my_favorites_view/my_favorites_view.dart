import 'package:dongu_mobile/presentation/widgets/restaurant_info_card/restaurant_info_card.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_list_tile/restaurant_info_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/address_text.dart';

class MyFavoritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Favorilerim",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildRowTitleLeftRight(context, "Konumun", "Değiştir"),
          Divider(
            thickness: 4,
            color: AppColors.borderAndDividerColor,
          ),
          AddressText(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
            child: Row(
              children: [
                buildSearchBar(context),
                Spacer(),
                SvgPicture.asset(ImageConstant.COMMONS_FILTER_ICON),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: context.dynamicWidht(0.06),
            ),
            child: LocaleText(
              text: "En Son Sipariş Verdiğim",
              style: AppTextStyles.bodyTitleStyle,
            ),
          ),
          Divider(
            thickness: 4,
            color: AppColors.borderAndDividerColor,
          ),
          RestaurantInfoListTile(
            packetNumber: "4 paket",
            restaurantName: "Mini Burger",
            distance: "74m",
            availableTime: "18:00-21:00",
          ),
          buildRowTitleLeftRight(context, "Diğer Takip Ettiklerim", "Liste Olarak Gör"),
          Divider(
            thickness: 4,
            color: AppColors.borderAndDividerColor,
          ),
          RestaurantInfoCard(
            packetNumber: "tükendi",
            restaurantName: "Uzun İsimli Bir Resto…",
            grade: "4.7",
            location: "Beşiktaş",
            distance: "254m",
            availableTime: '18:00-21:00',
          ),
        ],
      ),
    );
  }

  Padding buildRowTitleLeftRight(BuildContext context, String titleLeft, String titleRight) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: Row(
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
      ),
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

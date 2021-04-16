import 'package:dongu_mobile/presentation/screens/my_favorites_view/components/address_text.dart';
import 'package:dongu_mobile/presentation/screens/search_view/components/horizontal_list_category_bar.dart';
import 'package:dongu_mobile/presentation/widgets/restaurant_info_card/restaurant_info_card.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  ListView buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
        top: context.dynamicHeight(0.02),
        bottom: context.dynamicHeight(0.02),
      ),
      children: [
        buildRowTitleLeftRight(context, LocaleKeys.home_page_location, LocaleKeys.home_page_edit),
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
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, RouteConstant.FILTER_VIEW);
              },
              child: SvgPicture.asset(ImageConstant.COMMONS_FILTER_ICON)),
          ],
        ),
        SizedBox(height: context.dynamicHeight(0.03)),
        buildRowTitleLeftRight(context, LocaleKeys.home_page_closer, LocaleKeys.home_page_see_all),
        Divider(
          thickness: 4,
          color: AppColors.borderAndDividerColor,
        ),
        SizedBox(height: context.dynamicHeight(0.02)),
        buildListView(context),
        SizedBox(height: context.dynamicHeight(0.04)),
        LocaleText(
          text: LocaleKeys.home_page_categories,
          style: AppTextStyles.bodyTitleStyle,
        ),
        Divider(
          thickness: 4,
          color: AppColors.borderAndDividerColor,
        ),
        SizedBox(height: context.dynamicHeight(0.01)),
        Container(height: context.dynamicHeight(0.16), child: CustomHorizontalListCategory()),
        LocaleText(
          text: LocaleKeys.home_page_opportunities,
          style: AppTextStyles.bodyTitleStyle,
        ),
        Divider(
          thickness: 4,
          color: AppColors.borderAndDividerColor,
        ),
        SizedBox(height: context.dynamicHeight(0.01)),
        buildListView(context),
      ],
    );
  }

  Container buildListView(BuildContext context) {
    return Container(
      width: context.dynamicWidht(0.64),
      height: context.dynamicHeight(0.29),
      child: ListView.separated(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return RestaurantInfoCard(
            packetNumber: "4 paket",
            restaurantName: "Uzun İsimli Bir Resto…",
            grade: "4.7",
            location: "Beşiktaş",
            distance: "254m",
            availableTime: '18:00-21:00',
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          width: context.dynamicWidht(0.04),
        ),
      ),
    );
  }

  Row buildRowTitleLeftRight(BuildContext context, String titleLeft, String titleRight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        LocaleText(
          text: titleLeft,
          style: AppTextStyles.bodyTitleStyle,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteConstant.MY_NEAR_VIEW);
          },
          child: LocaleText(
            text: titleRight,
            style: GoogleFonts.montserrat(
              fontSize: 12.0,
              color: AppColors.orangeColor,
              fontWeight: FontWeight.w600,
              height: 2.0,
            ),
            alignment: TextAlign.right,
          ),
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

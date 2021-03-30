import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';


class CustomCard extends StatefulWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> with SingleTickerProviderStateMixin{
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller =  TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Container(//0.86 372.0 & 0.23 214
      width: context.dynamicWidht(0.86),
      height: context.dynamicHeight(0.23),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18.0),
          bottom: Radius.circular(8.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
           // indicatorSize: TabBarIndicatorSize.label,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 3, color: AppColors.orangeColor),
              insets: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.11))
            ),
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
            Tab(
              text: LocaleKeys.restaurant_detail_text1.locale,
            ),
            Tab(
              text: LocaleKeys.restaurant_detail_text2.locale,
            ),
          ]),
          Divider(
            thickness: 2,
            color: AppColors.borderAndDividerColor,
          ),
          Container(
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 1),
                  restaurantLogoContainer(context),
                  Spacer(flex:1),
                  restaurantTitleAndAddressColumn(),
                  Spacer(flex: 2),
                  restaurantStarIconRating(),
                  Spacer(flex: 1),
                ],
              ),
            ),
          ),
            Divider(
            thickness: 2,
            color: AppColors.borderAndDividerColor,
          ),
          Container(
            child: Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("clock"),
                    Text("4 paket"),
                    Text("75 TL"),
                    Text("35 TL"),
                  ],
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Servi"),
                    Text("Kalite"),
                    Text("Yemek"),
                  ],
                ),
              ]),
            ),
          ),
        ],//56
      ),
    );
  }

  Row restaurantStarIconRating() {
    return Row(
                  children: [
                    Container(
                      child: SvgPicture.asset(ImageConstant.RESTAURANT_STAR_ICON),
                    ),
                Text(
                      "4.7",
                      style: AppTextStyles.bodyTextStyle,
                    )
                  ],
                );
  }

  Column restaurantTitleAndAddressColumn() {
    return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LocaleText(
                      text: LocaleKeys.restaurant_detail_title,
                      style: AppTextStyles.appBarTitleStyle.copyWith(fontWeight: FontWeight.w600),
                    ),
                    LocaleText(
                      text: LocaleKeys.restaurant_detail_address,
                      style: AppTextStyles.subTitleStyle
                    ),
                  ],
                );
  }

  Container restaurantLogoContainer(BuildContext context) {
    return Container(
  width: context.dynamicWidht(0.22),
  height: context.dynamicHeight(0.2),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(4.0),
    color: Colors.white,
    border: Border.all(
      width: 2.0,
      color: AppColors.borderAndDividerColor,
    ),
  ),
  child: SvgPicture.asset(ImageConstant.RESTAURANT_LOGO, color: Colors.black,),
);
  }
}


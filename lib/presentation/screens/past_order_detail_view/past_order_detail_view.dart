import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import 'components/address_and_date_list_tile.dart';
import 'components/past_order_detail_basket_list_tile.dart';
import 'components/past_order_detail_body_title.dart';
import 'components/past_order_detail_payment_list_tile.dart';
import 'components/past_order_detail_total_payment_list_tile.dart';
import 'components/thanks_for_evaluation_container.dart';

class PastOrderDetailView extends StatefulWidget {
  @override
  _PastOrderDetailViewState createState() => _PastOrderDetailViewState();
}

class _PastOrderDetailViewState extends State<PastOrderDetailView> {
  int starDegreeService = 3;
  int starDegreeQuality = 3;
  int starDegreeTaste = 3;
  bool editVisibility = false;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.past_order_detail_title,
      body: buildBody(context),
    );
  }

  ListView buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        top: context.dynamicHeight(0.02),
      ),
      children: [
        AddressAndDateListTile(
          date: "27 Şubat 2021  20:08",
        ),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
        PastOrderDetailBodyTitle(
          title: LocaleKeys.past_order_detail_body_title_1,
        ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        buildRestaurantListTile(context),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
        buildRowTitleLeftRight(context, LocaleKeys.past_order_detail_body_title_2, LocaleKeys.past_order_detail_edit),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        buildStarListTile(context, LocaleKeys.past_order_detail_evaluate_1, "service"),
        buildStarListTile(context, LocaleKeys.past_order_detail_evaluate_2, "quality"),
        buildStarListTile(context, LocaleKeys.past_order_detail_evaluate_3, "taste"),
        Visibility(visible: editVisibility, child: ThanksForEvaluationContainer()),
        Visibility(
          visible: editVisibility,
          child: Column(
            children: [
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
              buildButtonSecond(context),
            ],
          ),
        ),
        Visibility(
          visible: !editVisibility,
          child: SizedBox(
            height: context.dynamicHeight(0.02),
          ),
        ),
        buildButtonFirst(context),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
        PastOrderDetailBodyTitle(
          title: LocaleKeys.past_order_detail_body_title_3,
        ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        PastOrderDetailBasketListTile(
          title: "Anadolu Lezzetleri",
          price: 35,
          withDecimal: false,
          subTitle: "Pastırmalı Kuru Fasulye,\n1 porsiyon Kornişon Turşu",
        ),
        PastOrderDetailBasketListTile(
          title: "Vegan 4 Paket",
          price: 35,
          withDecimal: false,
          subTitle: "Brokoli Salatası, Vegan Sos\nSoya Soslu Fasulye",
        ),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
        PastOrderDetailBodyTitle(
          title: LocaleKeys.past_order_detail_body_title_4,
        ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        PastOrderDetailPaymentListTile(
          title: LocaleKeys.past_order_detail_payment_1,
          price: 70,
          lineTrough: false,
          withDecimal: false,
        ),
        PastOrderDetailPaymentListTile(
          title: LocaleKeys.past_order_detail_payment_2,
          price: 4.50,
          lineTrough: true,
          withDecimal: true,
        ),
        PastOrderDetailPaymentListTile(
          title: "${LocaleKeys.past_order_detail_payment_3.locale} (2)*",
          price: 0.50,
          lineTrough: false,
          withDecimal: true,
        ),
        PastOrderDetailTotalPaymentListTile(
          title: LocaleKeys.past_order_detail_payment_4,
          price: 70.50,
          withDecimal: true,
        ),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
      ],
    );
  }

  Padding buildButtonSecond(BuildContext context) {
    return Padding(
              padding: EdgeInsets.only(left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
              child: CustomButton(
                width: double.infinity,
                title: LocaleKeys.past_order_detail_button_2,
                color: Colors.transparent,
                borderColor: AppColors.greenColor,
                textColor: AppColors.greenColor,
                onPressed: () {
                  setState(() {
                    editVisibility = true;
                  });
                },
              ),
            );
  }

  ListTile buildStarListTile(BuildContext context, String title, String whichStars) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildStar(whichStars, 1),
          Container(
            margin: EdgeInsets.only(left: context.dynamicWidht(0.02)),
            child: buildStar(whichStars, 2),
          ),
          Container(
            margin: EdgeInsets.only(left: context.dynamicWidht(0.02)),
            child: buildStar(whichStars, 3),
          ),
          Container(
            margin: EdgeInsets.only(left: context.dynamicWidht(0.02)),
            child: buildStar(whichStars, 4),
          ),
          Container(
            margin: EdgeInsets.only(left: context.dynamicWidht(0.02)),
            child: buildStar(whichStars, 5),
          ),
        ],
      ),
      tileColor: Colors.white,
      title: LocaleText(text: title, style: AppTextStyles.myInformationBodyTextStyle),
      onTap: () {},
    );
  }

  GestureDetector buildStar(String whichStars, int grade) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!editVisibility) {
            if (whichStars == "service") {
              starDegreeService = grade;
            } else if (whichStars == "quality") {
              starDegreeQuality = grade;
            } else {
              starDegreeTaste = grade;
            }
          }
        });
      },
      child: SvgPicture.asset(
        whichStars == "service"
            ? starDegreeService > grade - 1
                ? ImageConstant.PAST_ORDER_DETAIL_FILLED_STAR_ICON
                : ImageConstant.PAST_ORDER_DETAIL_STAR_ICON
            : whichStars == "quality"
                ? starDegreeQuality > grade - 1
                    ? ImageConstant.PAST_ORDER_DETAIL_FILLED_STAR_ICON
                    : ImageConstant.PAST_ORDER_DETAIL_STAR_ICON
                : starDegreeTaste > grade - 1
                    ? ImageConstant.PAST_ORDER_DETAIL_FILLED_STAR_ICON
                    : ImageConstant.PAST_ORDER_DETAIL_STAR_ICON,
      ),
    );
  }

  ListTile buildRestaurantListTile(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: SvgPicture.asset(
        ImageConstant.COMMONS_FORWARD_ICON,
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: "Canım Büfe",
        style: AppTextStyles.bodyTextStyle,
      ),
      onTap: () {},
    );
  }

  Padding buildRowTitleLeftRight(BuildContext context, String titleLeft, String titleRight) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocaleText(
            text: titleLeft,
            style: AppTextStyles.bodyTitleStyle,
          ),
          Visibility(
            visible: editVisibility,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  editVisibility = false;
                });
              },
              child: LocaleText(
                text: titleRight,
                style: GoogleFonts.montserrat(
                  fontSize: 12.0,
                  color: AppColors.orangeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Visibility buildButtonFirst(BuildContext context) {
    return Visibility(
      visible: !editVisibility,
      child: Padding(
        padding: EdgeInsets.only(left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
        child: CustomButton(
          width: double.infinity,
          title: LocaleKeys.past_order_detail_button_1,
          color: AppColors.greenColor,
          borderColor: AppColors.greenColor,
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              editVisibility = true;
            });
          },
        ),
      ),
    );
  }
}

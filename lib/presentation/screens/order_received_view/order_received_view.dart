import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
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
import '../../widgets/text/locale_text.dart';
import '../payment_views/payment_address_view/components/get_it_address_list_tile.dart';
import 'components/order_summary_container.dart';

class OrderReceivedView extends StatefulWidget {
  @override
  _OrderReceivedViewState createState() => _OrderReceivedViewState();
}

class _OrderReceivedViewState extends State<OrderReceivedView> {
  late Timer timer;
  int hour = 1;
  int minute = 51;
  int second = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  ListView buildBody(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        buildOrderNumberContainer(context),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        buildCountDown(context),
        SizedBox(
          height: context.dynamicHeight(0.04),
        ),
        Padding(
          padding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
          child: LocaleText(
              text: LocaleKeys.order_received_order_summary,
              style: AppTextStyles.bodyTitleStyle),
        ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        OrderSummaryContainer(),
        SizedBox(
          height: context.dynamicHeight(0.04),
        ),
        buildRowTitleLeftRight(
            context,
            LocaleKeys.order_received_delivery_address,
            LocaleKeys.order_received_show_on_map),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        GetItAddressListTile(
          restaurantName: "Canım Büfe", 
          address: "Kuruçeşme, Muallim Cad., No:18 Beşiktaş/İstanbul",
        ),
        SizedBox(
          height: context.dynamicHeight(0.04),
        ),
        buildButton(context, LocaleKeys.order_received_button_1,
            Colors.transparent, AppColors.greenColor),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        buildButton(context, LocaleKeys.order_received_button_2,
            AppColors.greenColor, Colors.white),
        SizedBox(
          height: context.dynamicHeight(0.06),
        ),
      ],
    );
  }

  Container buildOrderNumberContainer(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.dynamicHeight(0.22),
      color: Colors.white,
      child: Column(
        children: [
          Spacer(flex: 8),
          SvgPicture.asset(ImageConstant.ORDER_RECEIVING_PACKAGE_ICON),
          Spacer(flex: 4),
          LocaleText(
            text: LocaleKeys.order_received_headline,
            style: AppTextStyles.appBarTitleStyle.copyWith(
                fontWeight: FontWeight.w400, color: AppColors.orangeColor),
            alignment: TextAlign.center,
          ),
          Spacer(flex: 2),
          buildOrderNumber(),
          Spacer(flex: 5),
        ],
      ),
    );
  }

  AutoSizeText buildOrderNumber() {
    return AutoSizeText.rich(
      TextSpan(
        style: AppTextStyles.bodyTextStyle,
        children: [
          TextSpan(
            text: LocaleKeys.order_received_order_number.locale,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: '86123345',
            style: GoogleFonts.montserrat(
              color: AppColors.greenColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Container buildCountDown(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.dynamicHeight(0.1),
      color: Colors.white,
      child: Row(
        children: [
          Spacer(flex: 5),
          SvgPicture.asset(ImageConstant.ORDER_RECEIVED_CLOCK_ICON),
          Spacer(flex: 1),
          LocaleText(
              text: LocaleKeys.order_received_count_down,
              style: AppTextStyles.bodyTitleStyle),
          Spacer(flex: 1),
          Text(
              '0$hour:${minute < 10 ? "0$minute" : minute}:${second < 10 ? "0$second" : second}',
              style: AppTextStyles.appBarTitleStyle),
          Spacer(flex: 5),
        ],
      ),
    );
  }

  Padding buildButton(
      BuildContext context, String title, Color color, Color textColor) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: CustomButton(
        width: double.infinity,
        title: title,
        color: color,
        borderColor: AppColors.greenColor,
        textColor: textColor,
        onPressed: () {},
      ),
    );
  }

  Padding buildRowTitleLeftRight(
      BuildContext context, String titleLeft, String titleRight) {
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
          GestureDetector(
            onTap: () {},
            child: LocaleText(
              text: titleRight,
              style: GoogleFonts.montserrat(
                fontSize: 12.0,
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: SvgPicture.asset(ImageConstant.COMMONS_CLOSE_ICON),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: SvgPicture.asset(ImageConstant.COMMONS_APP_BAR_LOGO),
      centerTitle: true,
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (hour == 0 && minute == 0 && second == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            if (second != 0) {
              second--;
            } else {
              second = 59;
              if (minute != 0) {
                minute--;
              } else {
                minute = 59;
                hour--;
              }
            }
          });
        }
      },
    );
  }
}

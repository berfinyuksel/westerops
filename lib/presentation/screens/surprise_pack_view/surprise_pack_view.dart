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
import 'components/custom_alert_dialog.dart';

class SurprisePackView extends StatefulWidget {
  @override
  _SurprisePackViewState createState() => _SurprisePackViewState();
}

class _SurprisePackViewState extends State<SurprisePackView> {
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

  Column buildBody(BuildContext context) {
    return Column(
      children: [
        Spacer(
          flex: 18,
        ),
        LocaleText(
          text: LocaleKeys.surprise_pack_surprise_pack_opened,
          style: AppTextStyles.appBarTitleStyle.copyWith(
              fontWeight: FontWeight.w400, color: AppColors.orangeColor),
          alignment: TextAlign.center,
        ),
        Spacer(
          flex: 2,
        ),
        buildOrderNumber(),
        SvgPicture.asset(ImageConstant.SURPRISE_PACK,
            height: context.dynamicHeight(0.4)),
        buildCountDown(context),
        Spacer(
          flex: 5,
        ),
        // Container(child: Text("data"),),
        buildBottomCard(context),
      ],
    );
  }

  Container buildBottomCard(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.dynamicHeight(0.26),
      padding: EdgeInsets.symmetric(
        horizontal: context.dynamicWidht(0.06),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Spacer(
            flex: 39,
          ),
          buildFirstRow(context),
          buildSecondRow(context),
          Spacer(
            flex: 58,
          ),
          buildButtonsRow(context),
          Spacer(
            flex: 40,
          ),
        ],
      ),
    );
  }

  Row buildButtonsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          width: context.dynamicWidht(0.416),
          title: LocaleKeys.surprise_pack_button_reject,
          color: Colors.transparent,
          textColor: AppColors.redColor,
          borderColor: AppColors.redColor,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => CustomAlertDialog(
                    onPressedOne: () {},
                    onPressedTwo: () {},
                    imagePath: ImageConstant.SURPRISE_PACK_ALERT,
                    textMessage: LocaleKeys.surprise_pack_alert_text,
                    buttonOneTitle: LocaleKeys.surprise_pack_alert_button1,
                    buttonTwoTittle: LocaleKeys.surprise_pack_alert_button2));
          },
        ),
        CustomButton(
          width: context.dynamicWidht(0.416),
          title: LocaleKeys.surprise_pack_button_accept,
          color: AppColors.greenColor,
          textColor: Colors.white,
          borderColor: AppColors.greenColor,
        ),
      ],
    );
  }

  Padding buildSecondRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.dynamicWidht(0.01)),
      child: Row(
        children: [
          Spacer(),
          AutoSizeText(
            'Pastırmalı Kuru Fasulye,\n1 porsiyon Kornişon Turşu',
            style: AppTextStyles.subTitleStyle,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Padding buildFirstRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.05)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            '${LocaleKeys.surprise_pack_surprise_pack.locale} 1',
            style: AppTextStyles.myInformationBodyTextStyle,
          ),
          SvgPicture.asset(ImageConstant.SURPRISE_PACK_FORWARD_ICON),
          AutoSizeText(
            'Anadolu Lezzetleri',
            style: AppTextStyles.myInformationBodyTextStyle,
          ),
        ],
      ),
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
          Text(
            " kaldı.",
            style: AppTextStyles.bodyTitleStyle,
          ),
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

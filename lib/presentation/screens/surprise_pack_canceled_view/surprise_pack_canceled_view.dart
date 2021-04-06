import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/presentation/widgets/warning_container/warning_container.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/buy_button.dart';

class SurprisePackCanceled extends StatefulWidget {
  @override
  _SurprisePackCanceledState createState() => _SurprisePackCanceledState();
}

class _SurprisePackCanceledState extends State<SurprisePackCanceled> {
  int selectedIndex = 0;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Color(0xFFFEEFEF),
      body: Column(
        children: [
          Spacer(
            flex: 32,
          ),
          LocaleText(
            text: LocaleKeys.surprise_pack_canceled_canceled_your_pack,
            style: AppTextStyles.appBarTitleStyle.copyWith(fontWeight: FontWeight.w400, color: AppColors.orangeColor),
            alignment: TextAlign.center,
          ),
          Spacer(
            flex: 8,
          ),
          buildOrderNumber(),
          Spacer(
            flex: 32,
          ),
          buildSurprisePackContainer(context),
          Spacer(
            flex: 17,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
            child: WarningContainer(
              text: "Sürpriz Paketin iptal edildi.\nŞimdi tekrar satışta. Fikrini değiştirirsen\nacele etmelisin.",
            ),
          ),
          Spacer(
            flex: 20,
          ),
          buildBottomCard(context)
        ],
      ),
    );
  }

  Container buildBottomCard(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.dynamicHeight(0.52),
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
          Spacer(
            flex: 18,
          ),
          buildSecondRow(context),
          Spacer(
            flex: 22,
          ),
          Divider(
            color: AppColors.borderAndDividerColor,
            thickness: 2,
            height: 0,
          ),
          Spacer(
            flex: 22,
          ),
          Column(
            children: buildRadioButtons(context),
          ),
          Spacer(
            flex: 5,
          ),
          buildTextFormField(LocaleKeys.delete_account_hint_text.locale, textController),
          Spacer(
            flex: 20,
          ),
          buildCustomButton(),
          Spacer(
            flex: 32,
          ),
          Divider(
            color: AppColors.borderAndDividerColor,
            thickness: 2,
            height: 0,
          ),
          Spacer(
            flex: 32,
          ),
          LocaleText(
            text: LocaleKeys.surprise_pack_canceled,
            style: GoogleFonts.montserrat(
              fontSize: 18.0,
              color: AppColors.redColor,
              fontWeight: FontWeight.w400,
            ),
            alignment: TextAlign.center,
          ),
          Spacer(
            flex: 34,
          ),
        ],
      ),
    );
  }

  CustomButton buildCustomButton() {
    return CustomButton(
      width: double.infinity,
      title: LocaleKeys.surprise_pack_canceled_button_send,
      color: Colors.transparent,
      borderColor: AppColors.greenColor,
      textColor: AppColors.greenColor,
      onPressed: () {},
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

  Container buildSurprisePackContainer(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.1),
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06), vertical: context.dynamicHeight(0.01)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  'Anadolu Lezzetleri',
                  style: AppTextStyles.myInformationBodyTextStyle,
                ),
                AutoSizeText(
                  "07:00:20",
                  style: AppTextStyles.subTitleStyle,
                ),
                BuyButton(),
              ],
            ),
            AutoSizeText(
              'Pastırmalı Kuru Fasulye,\n1 porsiyon Kornişon Turşu',
              style: AppTextStyles.subTitleStyle,
              textAlign: TextAlign.start,
            ),
          ],
        ),
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

  Container buildTextFormField(String hintText, TextEditingController controller) {
    return Container(
      height: context.dynamicHeight(0.052),
      color: Colors.white,
      child: TextFormField(
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.bodyTextStyle,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.subTitleStyle,
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          border: buildOutlineInputBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderAndDividerColor, width: 2),
      borderRadius: BorderRadius.circular(4.0),
    );
  }

  buildRadioButtons(BuildContext context) {
    List<Widget> buttons = [];

    for (int i = 0; i < 3; i++) {
      buttons.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = i;
            });
          },
          child: Container(
            margin: EdgeInsets.only(
              bottom: context.dynamicHeight(0.02),
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    right: context.dynamicWidht(0.02),
                  ),
                  height: context.dynamicWidht(0.05),
                  width: context.dynamicWidht(0.05),
                  padding: EdgeInsets.all(
                    context.dynamicWidht(0.005),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xFFD1D0D0),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: selectedIndex == i ? AppColors.greenColor : Colors.transparent),
                  ),
                ),
                LocaleText(
                  text: "Açıklama ${i + 1}",
                  style: AppTextStyles.bodyTextStyle,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return buttons;
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
}

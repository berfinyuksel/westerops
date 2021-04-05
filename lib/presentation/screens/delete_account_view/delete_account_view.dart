import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
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

class DeleteAccountView extends StatefulWidget {
  @override
  _DeleteAccountViewState createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
  int selectedIndex = 0;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.delete_account_title,
      body: buildBody(context),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
        bottom: context.dynamicHeight(0.03),
      ),
      child: Column(
        children: [
          Spacer(flex: 72),
          SvgPicture.asset(
            ImageConstant.DELETE_ACCOUNT_LOVE,
            height: context.dynamicHeight(0.1),
          ),
          Spacer(flex: 26),
          buildLocaleTextFirst(),
          Spacer(flex: 10),
          buildLocaleTextSecond(context),
          Spacer(flex: 62),
          Column(
            children: buildRadioButtons(context),
          ),
          Spacer(flex: 2),
          buildTextFormField(LocaleKeys.delete_account_hint_text, textController),
          Spacer(flex: 91),
          buildCustomButton()
        ],
      ),
    );
  }

  Padding buildLocaleTextSecond(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.02)),
      child: LocaleText(
        text: LocaleKeys.delete_account_text_2,
        style: AppTextStyles.myInformationBodyTextStyle,
        alignment: TextAlign.center,
        maxLines: 4,
      ),
    );
  }

  LocaleText buildLocaleTextFirst() {
    return LocaleText(
      text: LocaleKeys.delete_account_text_1,
      style: GoogleFonts.montserrat(
        fontSize: 18.0,
        color: AppColors.textColor,
        fontWeight: FontWeight.w600,
      ),
      alignment: TextAlign.center,
    );
  }

  CustomButton buildCustomButton() {
    return CustomButton(
      width: double.infinity,
      title: LocaleKeys.delete_account_button,
      color: Colors.transparent,
      borderColor: Color(0xFFF36262),
      textColor: Color(0xFFF36262),
      onPressed: () {},
    );
  }

  buildRadioButtons(BuildContext context) {
    List<Widget> buttons = [];

    for (int i = 0; i < 4; i++) {
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
}

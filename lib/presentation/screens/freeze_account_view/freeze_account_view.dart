import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/user_auth_cubit/user_auth_cubit.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/components/popup_reset_password.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

class FreezeAccountView extends StatefulWidget {
  @override
  _FreezeAccountViewState createState() => _FreezeAccountViewState();
}

class _FreezeAccountViewState extends State<FreezeAccountView> {
  int selectedIndex = 0;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.freeze_account_title,
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
            ImageConstant.FREEZE_ACCOUNT_LOVE,
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
          buildTextFormField(
              LocaleKeys.freeze_account_hint_text.locale, textController),
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
        text: LocaleKeys.freeze_account_text_2,
        style: AppTextStyles.myInformationBodyTextStyle,
        alignment: TextAlign.center,
        maxLines: 4,
      ),
    );
  }

  LocaleText buildLocaleTextFirst() {
    return LocaleText(
      text: LocaleKeys.freeze_account_text_1,
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
      title: LocaleKeys.freeze_account_button,
      color: Colors.transparent,
      borderColor: Color(0xFFFFBC41),
      textColor: Color(0xFFFFBC41),
      onPressed: () async {
        await context
            .read<UserAuthCubit>()
            .deleteAccountUser(selectedIndex.toString());
        //SharedPrefs.clearCache();
             if (selectedIndex >= 0 || textController.text.isNotEmpty) {
          showDialog(
              context: context,
              builder: (_) => CustomAlertDialogResetPassword(
                    description:
                        LocaleKeys.freeze_account_popup_text_successful.locale,
                    onPressed: () => Navigator.popAndPushNamed(
                        context, RouteConstant.CUSTOM_SCAFFOLD),
                  ));
        } else {
          showDialog(
              context: context,
              builder: (_) => CustomAlertDialogResetPassword(
                    description:
                        LocaleKeys.freeze_account_popup_text_fail.locale,
                    onPressed: () => Navigator.popAndPushNamed(
                        context, RouteConstant.CUSTOM_SCAFFOLD),
                  ));
        }
      },
    );
  }

  buildRadioButtons(BuildContext context) {
    List<Widget> buttons = [];
    List<String> des = [
      LocaleKeys.freeze_account_text_3,
      LocaleKeys.freeze_account_text_4,
      LocaleKeys.freeze_account_text_5,
      LocaleKeys.freeze_account_text_6,
      LocaleKeys.freeze_account_text_7,
    ];

    for (int i = 0; i < 5; i++) {
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
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedIndex == i
                            ? AppColors.greenColor
                            : Colors.transparent),
                  ),
                ),
                LocaleText(
                  text: des[i],
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

  Container buildTextFormField(
      String hintText, TextEditingController controller) {
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

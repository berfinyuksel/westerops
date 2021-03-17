import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/presentation/screens/register_view/components/sign_with_social_auth.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool enableObscure = true;
  String dropdownValue = "TR";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: buildBackground,
          ),
          Positioned(
            bottom: 0,
            left: context.dynamicWidht(0.035),
            right: context.dynamicWidht(0.035),
            child: buildCardBody(context),
          ),
        ],
      ),
    );
  }

  Container buildCardBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.dynamicHeight(0.02),
      ),
      height: context.dynamicHeight(0.54),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          LocaleText(
            text: LocaleKeys.login_text_login,
            maxLines: 1,
            style: AppTextStyles.appBarTitleStyle,
          ),
          Divider(
            thickness: 4,
            color: AppColors.borderAndDividerColor,
          ),
          Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDropDown(context),
                  Container(
                    height: context.dynamicHeight(0.06),
                    width: context.dynamicWidht(0.57),
                    child: buildTextFormField(LocaleKeys.register_phone.locale, phoneController),
                  ),
                ],
              ),
            ),
          ),
          Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
              child: buildTextFormField(LocaleKeys.register_password.locale, passwordController),
            ),
          ),
          Spacer(flex: 2),
          CustomButton(
            width: context.dynamicWidht(0.4),
            title: LocaleKeys.login_text_login,
            textColor: Colors.white,
            color: AppColors.greenColor,
            borderColor: AppColors.greenColor,
          ),
          Spacer(flex: 1),
          LocaleText(
            text: LocaleKeys.login_forgot_pass,
            style: AppTextStyles.bodyTextStyle,
            maxLines: 1,
          ),
          Spacer(flex: 2),
          Expanded(
            flex: 4,
            child: buildSocialAuths(context),
          ),
          Spacer(
            flex: 2,
          ),
          AutoSizeText.rich(
            TextSpan(
              style: AppTextStyles.bodyTextStyle,
              children: [
                TextSpan(
                  text: LocaleKeys.login_dont_have_account.locale,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextSpan(
                  text: LocaleKeys.login_sign_up.locale,
                  style: GoogleFonts.montserrat(
                    color: AppColors.greenColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }

  Padding buildSocialAuths(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SignWithSocialAuth(
            image: ImageConstant.REGISTER_LOGIN_GOOGLE_ICON,
          ),
          SignWithSocialAuth(
            image: ImageConstant.REGISTER_LOGIN_FACEBOOK_ICON,
          ),
        ],
      ),
    );
  }

  Container get buildBackground {
    return Container(
      decoration: BoxDecoration(),
      child: SvgPicture.asset(
        ImageConstant.LOGIN_BACKGROUND,
        fit: BoxFit.fill,
      ),
    );
  }

  Container buildDropDown(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.06),
      width: context.dynamicWidht(0.19),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: AppColors.borderAndDividerColor,
          width: 2,
        ),
      ),
      child: DropdownButton<String>(
        underline: Text(""),
        value: dropdownValue,
        icon: Padding(
          padding: EdgeInsets.only(left: context.dynamicWidht(0.04)),
          child: const Icon(Icons.keyboard_arrow_down),
        ),
        iconSize: 15,
        style: AppTextStyles.bodyBoldTextStyle,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['TR', 'EN'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: AutoSizeText(
              value,
              style: AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w500),
              maxLines: 1,
            ),
          );
        }).toList(),
      ),
    );
  }

  TextFormField buildTextFormField(String labelText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      obscureText: enableObscure && controller == passwordController,
      decoration: InputDecoration(
        prefixText: controller == phoneController
            ? dropdownValue == 'TR'
                ? "+90"
                : "+1"
            : "",
        suffixIconConstraints:
            controller == passwordController ? BoxConstraints.tightFor(width: context.dynamicWidht(0.05), height: context.dynamicHeight(0.02)) : null,
        suffixIcon: controller == passwordController
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    enableObscure = !enableObscure;
                  });
                },
                child: enableObscure
                    ? SvgPicture.asset(
                        ImageConstant.REGISTER_LOGIN_OBSCURE_ENABLE_ICON,
                      )
                    : SvgPicture.asset(
                        ImageConstant.REGISTER_LOGIN_OBSCURE_DISABLE_ICON,
                      ),
              )
            : null,
        labelText: labelText,
        labelStyle: AppTextStyles.subTitleStyle,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderAndDividerColor, width: 2),
          borderRadius: BorderRadius.circular(4.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderAndDividerColor, width: 2),
          borderRadius: BorderRadius.circular(4.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}

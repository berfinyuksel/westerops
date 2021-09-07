import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/services/auth_service.dart';
import '../../../logic/cubits/user_auth_cubit/user_auth_cubit.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';
import '../register_view/components/sign_with_social_auth.dart';

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
            top: context.dynamicHeight(0.06),
            left: 0,
            child: IconButton(
              icon: SvgPicture.asset(ImageConstant.BACK_ICON,
                  color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
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
      padding: EdgeInsets.only(
        bottom: context.dynamicHeight(0.02),
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
          Spacer(flex: 2),
          LocaleText(
            text: LocaleKeys.login_text_login,
            maxLines: 1,
            style: AppTextStyles.appBarTitleStyle,
          ),
          Spacer(flex: 2),
          Divider(
            thickness: 4,
            height: 0,
            color: AppColors.borderAndDividerColor,
          ),
          Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDropDown(context),
                  Container(
                    height: context.dynamicHeight(0.06),
                    width: context.dynamicWidht(0.57),
                    child: buildTextFormField(
                        LocaleKeys.register_phone.locale, phoneController),
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
              padding:
                  EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
              child: buildTextFormField(
                  LocaleKeys.register_password.locale, passwordController),
            ),
          ),
          Spacer(flex: 2),
          CustomButton(
            width: context.dynamicWidht(0.4),
            title: LocaleKeys.login_text_login,
            textColor: Colors.white,
            color: AppColors.greenColor,
            borderColor: AppColors.greenColor,
            onPressed: () async {
              String phoneTR = '+90' + phoneController.text;
              String phoneEN = '+1' + phoneController.text;
              await context
                  .read<UserAuthCubit>()
                  .loginUser(
                  dropdownValue == 'TR' ? phoneTR : phoneEN, passwordController.text);
              if (SharedPrefs.getIsLogined) {
                Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
              }
            },
          ),
          Spacer(flex: 1),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.FORGOT_PASSWORD_VIEW);
            },
            child: LocaleText(
              text: LocaleKeys.login_forgot_pass,
              style: AppTextStyles.bodyTextStyle,
              maxLines: 1,
            ),
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
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, RouteConstant.REGISTER_VIEW);
                    },
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
          GestureDetector(
            onTap: () {
              AuthService.loginWithGmail();
              Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
            },
            child: SignWithSocialAuth(
              image: ImageConstant.REGISTER_LOGIN_GOOGLE_ICON,
            ),
          ),
          GestureDetector(
            onTap: () {
              //  AuthService.loginWithFacebook();
            },
            child: SignWithSocialAuth(
              image: ImageConstant.REGISTER_LOGIN_FACEBOOK_ICON,
            ),
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
        style:
            AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items:
            <String>['TR', 'EN'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: AutoSizeText(
              value,
              style: AppTextStyles.bodyTextStyle
                  .copyWith(fontWeight: FontWeight.w600),
              maxLines: 1,
            ),
          );
        }).toList(),
      ),
    );
  }

  TextFormField buildTextFormField(
      String labelText, TextEditingController controller) {
            String phoneTR = '+90';
    String phoneEN = '+1';
    return TextFormField(
      keyboardType: TextInputType.number,
    //  focusNode: FocusScope.of(context).focusedChild!.children.first,
      cursorColor: AppColors.cursorColor,
      style: AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
      controller: controller,
      obscureText: enableObscure && controller == passwordController,
      decoration: InputDecoration(
        prefixStyle:
            AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
        prefixText: controller == phoneController
            ? dropdownValue == 'TR'
                ? phoneTR
                : phoneEN
            : "",
        suffixIconConstraints: controller == passwordController
            ? BoxConstraints.tightFor(
                width: context.dynamicWidht(0.09),
                height: context.dynamicWidht(0.06))
            : null,
        suffixIcon: controller == passwordController
            ? Padding(
                padding: EdgeInsets.only(right: context.dynamicWidht(0.03)),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      enableObscure = !enableObscure;
                    });
                  },
                  child: enableObscure
                      ? SvgPicture.asset(
                          ImageConstant.REGISTER_LOGIN_OBSCURE_ENABLE_ICON,
                          color: AppColors.iconColor,
                        )
                      : SvgPicture.asset(
                          ImageConstant.REGISTER_LOGIN_OBSCURE_DISABLE_ICON,
                          color: AppColors.iconColor,
                        ),
                ),
              )
            : null,
        labelText: labelText,
        labelStyle: AppTextStyles.bodyTextStyle,
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.borderAndDividerColor, width: 2),
          borderRadius: BorderRadius.circular(4.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.borderAndDividerColor, width: 2),
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

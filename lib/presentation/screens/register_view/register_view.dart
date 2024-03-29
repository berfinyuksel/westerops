import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/forgot_password_view.dart';
import 'package:dongu_mobile/presentation/screens/register_view/components/error_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:validators/validators.dart';

import '../../../data/services/apple_login_controller.dart';
import '../../../data/services/auth_service.dart';
import '../../../data/services/facebook_login_controller.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';
import 'components/clipped_password_rules.dart';
import 'components/contract_text.dart';
import 'components/error_popup.dart';
import 'components/password_rules.dart';
import 'components/sign_with_social_auth.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showLoading = false;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  String? verificationId;

  bool enableObscure = true;
  String dropdownValue = "TR";
  bool checkboxValue = false;
  bool isRulesVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: GestureDetector(
          onTap: () {
            setState(() {
              if (isRulesVisible) {
                isRulesVisible = false;
              }
              FocusScope.of(context).unfocus();
            });
          },
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: buildBackground,
              ),
              Positioned(
                top: 28.h,
                left: 5.w,
                child: IconButton(
                  icon: SvgPicture.asset(ImageConstant.BACK_ICON,
                      width: 20.w, height: 20.w, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Positioned(
                bottom: -10.h,
                left: 15.w,
                right: 15.w,
                child: buildCardBody(context),
              ),
              Positioned(
                top: context.dynamicHeight(0.53),
                left: context.dynamicWidht(0.095),
                child: Visibility(
                    visible: isRulesVisible,
                    child: ClippedPasswordRules(
                      child:
                          PasswordRules(passwordController: passwordController),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCardBody(BuildContext context) {
    String phoneTR = '+90' + phoneController.text;
    //String phoneEN = '+1' + phoneController.text;

    return Container(
      padding: EdgeInsets.only(
        bottom: 20.h,
      ),
      height: 630.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(height: 21.h),
          buildHeader(),
          SizedBox(height: 19.5.h),
          buildDivider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  buildPhoneField(context),
                  SizedBox(height: 20.h),
                  buildNameField(),
                  SizedBox(height: 20.h),
                  buildEmailField(),
                  SizedBox(height: 20.h),
                  buildPasswordField(),
                  SizedBox(height: 20.h),
                  buildRegisterButton(phoneTR, context),
                  SizedBox(height: 20.h),
                  ContractText(),
                  SizedBox(height: 20.h),
                  buildSocialAuths(context),
                  SizedBox(height: 27.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  CustomButton buildRegisterButton(String phoneTR, BuildContext context) {
    return CustomButton(
        width: 176.w,
        title: LocaleKeys.register_text_register,
        textColor: Colors.white,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        onPressed: () {
          bool numberControl =
              passwordController.text.contains(RegExp(r'[0-9]'));
          bool uppercaseControl =
              passwordController.text.contains(RegExp(r'[A-Z]'));
          bool phoneControl = phoneTR.length >= 13;
          String firstName = nameController.text;
          String lastName = nameController.text;
          firstName.split(" ");
          lastName.split(" ");
          if (phoneController.text.isEmpty ||
              firstName.isEmpty ||
              lastName.isEmpty ||
              emailController.text.isEmpty ||
              passwordController.text.isEmpty) {
            showDialog(
              context: context,
              builder: (_) => CustomErrorPopup(
                textMessage: LocaleKeys.register_fail_pop_up_text_title.locale,
                buttonOneTitle: LocaleKeys.payment_payment_cancel,
                buttonTwoTittle: LocaleKeys.address_address_approval,
                imagePath: ImageConstant.COMMONS_WARNING_ICON,
                onPressedOne: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          } else if (!uppercaseControl || !phoneControl || !numberControl) {
            showDialog(
              context: context,
              builder: (_) => CustomErrorPopup(
                textMessage:
                    "Eksik veya hatalı doldurdunuz. \nLütfen tekrar deneyiniz",
                buttonOneTitle: "Tamam",
                buttonTwoTittle: LocaleKeys.address_address_approval,
                imagePath: ImageConstant.COMMONS_WARNING_ICON,
                onPressedOne: () {
                  Navigator.of(context).pop();
                },
              ),
            );
          } else {
            //String phoneEN = '+1' + phoneController.text;
            if (nameController.text.isNotEmpty &&
                phoneController.text.isNotEmpty &&
                passwordController.text.isNotEmpty &&
                lastName.isNotEmpty &&
                firstName.isNotEmpty) {
              SharedPrefs.setUserName(firstName.split(" ").first);
              SharedPrefs.setUserLastName(lastName.split(" ").last);
              SharedPrefs.setUserPhone(phoneTR);
              SharedPrefs.setUserEmail(emailController.text);
              SharedPrefs.setUserPassword(passwordController.text);
              SharedPrefs.setSocialLogin(false);
              Navigator.popAndPushNamed(
                  context, RouteConstant.REGISTER_VERIFY_VIEW);
            } else {
              ErrorAlertDialog(onTap: () {});
            }
          }
        });
  }

  Container buildPasswordField() {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: buildTextFormFieldPassword(LocaleKeys.register_password.locale),
    );
  }

  Container buildEmailField() {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: buildTextFormField(
          false,
          LocaleKeys.register_email.locale,
          emailController,
          (val) => isEmail(emailController.text) ? "Invalid Email" : null),
    );
  }

  Container buildNameField() {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: buildTextFormField(
          false, LocaleKeys.register_full_name.locale, nameController, (value) {
        return null;
      }),
    );
  }

  Container buildPhoneField(BuildContext context) {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // buildDropDown(context),
          // SizedBox(width: 5.w),
          Expanded(
            child: buildTextFormField(
                true,
                LocaleKeys.register_phone.locale,
                phoneController,
                (val) =>
                    !isNumeric(phoneController.text) ? "Invalid Phone" : null),
          ),
        ],
      ),
    );
  }

  Divider buildDivider() {
    return Divider(
      height: 0,
      thickness: 4,
      color: AppColors.borderAndDividerColor,
    );
  }

  LocaleText buildHeader() {
    return LocaleText(
      text: LocaleKeys.register_text_register,
      maxLines: 1,
      style: AppTextStyles.appBarTitleStyle,
    );
  }

  Container buildCheckBox(BuildContext context) {
    return Container(
      height: 32.h,
      width: 32.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: Color(0xFFD1D0D0),
        ),
      ),
      child: Theme(
        data: ThemeData(unselectedWidgetColor: Colors.transparent),
        child: Checkbox(
          checkColor: Colors.greenAccent,
          activeColor: Colors.transparent,
          value: checkboxValue,
          onChanged: (value) {
            setState(() {
              checkboxValue = value!;
            });
          },
        ),
      ),
    );
  }

  Widget buildSocialAuths(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
            visible: !Platform.isAndroid,
            child: GestureDetector(
                onTap: () async {
                  await AppleSignInController().login();
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteConstant.CUSTOM_SCAFFOLD,
                      ModalRoute.withName('/scaf'));
                },
                child: SignWithSocialAuth(
                  text: LocaleKeys.register_social_auth_apple,
                  image: ImageConstant.REGISTER_LOGIN_APPLE_ICON,
                ))),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: () {
            AuthService().loginWithGmail();
            Navigator.of(context).pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
          },
          child: SignWithSocialAuth(
            text: LocaleKeys.register_social_auth_google,
            image: ImageConstant.REGISTER_LOGIN_GOOGLE_ICON,
          ),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: () {
            FacebookSignInController().login();
            Navigator.of(context).pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
          },
          child: SignWithSocialAuth(
            text: LocaleKeys.register_social_auth_facebook,
            image: ImageConstant.REGISTER_LOGIN_FACEBOOK_ICON,
          ),
        ),
      ],
    );
  }

  Container get buildBackground {
    return Container(
      height: context.dynamicHeight(1),
      width: context.dynamicWidht(1),
      decoration: BoxDecoration(),
      child: SvgPicture.asset(
        ImageConstant.REGISTER_BACKGROUND,
        fit: BoxFit.cover,
      ),
    );
  }

  /*  Container buildDropDown(BuildContext context) {
    return Container(
      height: 56.h,
      width: 81.w,
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
          padding: EdgeInsets.only(left: 20.w),
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
  } */

  TextFormField buildTextFormFieldPassword(String labelText) {
    return TextFormField(
      cursorColor: AppColors.cursorColor,
      style: AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
      onChanged: (value) {
        setState(() {
          isRulesVisible = true;
        });
      },
      inputFormatters: [
        //FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      controller: passwordController,
      obscureText: enableObscure,
      decoration: InputDecoration(
        suffixIconConstraints:
            BoxConstraints.tightFor(width: 35.w, height: 35.h),
        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 15.w),
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
        ),
        labelText: labelText,
        prefix: Text(
          "",
        ),
        labelStyle: AppTextStyles.bodyTextStyle,
        prefixStyle:
            AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
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

  TextFormField buildTextFormField(bool isCharacterLimited, String labelText,
      TextEditingController controller, String? Function(String?)? validator) {
    String phoneTR = '+90';
    String phoneEN = '+1';

    return TextFormField(
      cursorColor: AppColors.cursorColor,
      style: AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
      onTap: () {
        setState(() {
          isRulesVisible = false;
        });
      },
      validator: validator,
      keyboardType: TextInputType.number,
      inputFormatters: [
        isCharacterLimited
            ? LengthLimitingTextInputFormatter(10)
            : LengthLimitingTextInputFormatter(null),
        //FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
        controller == phoneController
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.singleLineFormatter,
      ],
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixText: controller == phoneController
            ? dropdownValue == 'TR'
                ? phoneTR
                : phoneEN
            : null,
        labelStyle: AppTextStyles.bodyTextStyle,
        prefixStyle:
            AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
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
      textInputAction: TextInputAction.next,
    );
  }
}

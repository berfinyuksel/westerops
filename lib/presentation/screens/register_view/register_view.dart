import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/presentation/screens/register_view/components/clipped_password_rules.dart';
import 'package:dongu_mobile/presentation/screens/register_view/components/consent_text.dart';
import 'package:dongu_mobile/presentation/screens/register_view/components/contract_text.dart';
import 'package:dongu_mobile/presentation/screens/register_view/components/sign_with_social_auth.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool enableObscure = true;
  String dropdownValue = "TR";
  bool checkboxValue = false;
  bool isRulesVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            if (isRulesVisible) {
              isRulesVisible = false;
            }
          });
        },
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: buildBackground,
            ),
            Positioned(
              top: context.dynamicHeight(0.04),
              left: context.dynamicWidht(0.035),
              child: IconButton(
                icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              bottom: 0,
              left: context.dynamicWidht(0.035),
              right: context.dynamicWidht(0.035),
              child: buildCardBody(context),
            ),
            Positioned(
              top: context.dynamicHeight(0.53),
              left: context.dynamicWidht(0.095),
              child: Visibility(visible: isRulesVisible, child: ClippedPasswordRules(passwordController: passwordController)),
            ),
          ],
        ),
      ),
    );
  }

  Container buildCardBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.dynamicHeight(0.02),
      ),
      height: context.dynamicHeight(0.69),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          LocaleText(
            text: LocaleKeys.register_text_register,
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
            flex: 5,
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
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
              child: buildTextFormField(LocaleKeys.register_full_name.locale, nameController),
            ),
          ),
          Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
              child: buildTextFormField(LocaleKeys.register_email.locale, emailController),
            ),
          ),
          Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
              child: buildTextFormFieldPassword(LocaleKeys.register_password.locale),
            ),
          ),
          Spacer(
            flex: 2,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCheckBox(context),
                Spacer(
                  flex: 1,
                ),
                ConsentText(),
              ],
            ),
          ),
          Spacer(
            flex: 2,
          ),
          CustomButton(
            width: context.dynamicWidht(0.4),
            title: LocaleKeys.register_text_register,
            textColor: Colors.white,
            color: checkboxValue ? AppColors.greenColor : AppColors.disabledButtonColor,
            borderColor: checkboxValue ? AppColors.greenColor : AppColors.disabledButtonColor,
          ),
          Spacer(
            flex: 2,
          ),
          ContractText(),
          Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 4,
            child: buildSocialAuths(context),
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }

  Container buildCheckBox(BuildContext context) {
    return Container(
      height: context.dynamicWidht(0.08),
      width: context.dynamicWidht(0.08),
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
        ImageConstant.REGISTER_BACKGROUND,
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

  TextFormField buildTextFormFieldPassword(String labelText) {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          isRulesVisible = true;
        });
      },
      controller: passwordController,
      obscureText: enableObscure,
      decoration: InputDecoration(
        suffixIconConstraints: BoxConstraints.tightFor(width: context.dynamicWidht(0.05), height: context.dynamicHeight(0.02)),
        suffixIcon: GestureDetector(
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
        ),
        labelText: labelText,
        prefix: Text(
          "",
        ),
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

  TextFormField buildTextFormField(String labelText, TextEditingController controller) {
    return TextFormField(
      onTap: () {
        setState(() {
          isRulesVisible = false;
        });
      },
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixText: controller == phoneController
            ? dropdownValue == 'TR'
                ? "+90"
                : "+1"
            : null,
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

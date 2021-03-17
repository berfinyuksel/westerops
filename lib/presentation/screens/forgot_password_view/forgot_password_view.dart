import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  bool enableObscure = true;
  bool isCodeSent = false;
  String dropdownValue = "TR";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("This will be changed"),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: context.dynamicHeight(0.04),
          left: context.dynamicWidht(0.06),
          right: context.dynamicWidht(0.06),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildDropDown(context),
                Container(
                  height: context.dynamicHeight(0.06),
                  width: context.dynamicWidht(0.57),
                  child: buildTextFormField(LocaleKeys.forgot_password_phone.locale, phoneController),
                ),
              ],
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            Visibility(visible: isCodeSent, child: buildTextFormField(LocaleKeys.forgot_password_activation_code.locale, codeController)),
            Visibility(
              visible: isCodeSent,
              child: SizedBox(
                height: context.dynamicHeight(0.02),
              ),
            ),
            Visibility(visible: isCodeSent, child: buildTextFormField(LocaleKeys.forgot_password_new_password.locale, passwordController)),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            CustomButton(
              onPressed: () {
                setState(() {
                  isCodeSent = true;
                });
              },
              width: double.infinity,
              title: isCodeSent ? LocaleKeys.forgot_password_reset_password : LocaleKeys.forgot_password_send_code,
              color: isCodeSent ? AppColors.disabledButtonColor : AppColors.greenColor,
              borderColor: isCodeSent ? AppColors.disabledButtonColor : AppColors.greenColor,
              textColor: Colors.white,
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            buildVisibilitySendAgainCode,
          ],
        ),
      ),
    );
  }

  Visibility get buildVisibilitySendAgainCode {
    return Visibility(
      visible: isCodeSent,
      child: Row(
        children: [
          Spacer(flex: 10),
          SvgPicture.asset(ImageConstant.FORGOT_PASSWORD_SEND_AGAIN_ICON),
          Spacer(flex: 1),
          LocaleText(
            text: LocaleKeys.forgot_password_send_again,
            style: AppTextStyles.bodyTextStyle,
            alignment: TextAlign.center,
          ),
          Spacer(flex: 10),
        ],
      ),
    );
  }

  Container buildDropDown(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.06),
      width: context.dynamicWidht(0.19),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
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
        fillColor: Colors.white,
        filled: true,
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

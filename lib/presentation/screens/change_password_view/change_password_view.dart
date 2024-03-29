import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../forgot_password_view/components/popup_reset_password.dart';
import '../register_view/components/clipped_password_rules.dart';
import '../register_view/components/password_rules.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordAgainController = TextEditingController();

  bool enableObscureOldPass = true;
  bool enableObscureNewPass = true;
  bool enableObscureNewAgainPass = true;
  bool isRulesVisible = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isRulesVisible = false;
        });
      },
      child: CustomScaffold(
        title: LocaleKeys.change_password_title,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                bottom: 20.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [buildTextFields(), buildButton(context)],
              ),
            ),
            Positioned(
              top: context.height > 800
                  ? context.dynamicHeight(0.03)
                  : context.dynamicHeight(0.125),
              left: context.dynamicWidht(0.365),
              right: context.dynamicWidht(0.365),
              child: Visibility(
                  visible: isRulesVisible,
                  child: ClippedPasswordRules(
                    child: PasswordRules(
                        passwordController: newPasswordController),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Container buildTextFields() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          buildTextFormFieldPassword(
              LocaleKeys.change_password_current_password.locale,
              passwordController),
          buildTextFormFieldNewPassword(
              LocaleKeys.change_password_new_password.locale),
          buildTextFormFieldPassword(
              LocaleKeys.change_password_new_password_again.locale,
              newPasswordAgainController)
        ],
      ),
    );
  }

  TextFormField buildTextFormFieldPassword(
      String labelText, TextEditingController controller) {
    return TextFormField(
      style: AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
      cursorColor: AppColors.cursorColor,
      onTap: () {
        setState(() {
          isRulesVisible = false;
        });
      },
      inputFormatters: [
        //FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      controller: controller,
      obscureText: controller == passwordController
          ? enableObscureOldPass
          : enableObscureNewAgainPass,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 28.w),
        suffixIconConstraints:
            BoxConstraints.tightFor(width: 50.w, height: 60.h),
        suffixIcon: Padding(
          padding: EdgeInsets.only(
            right: 25.w,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (controller == passwordController) {
                  enableObscureOldPass = !enableObscureOldPass;
                } else {
                  enableObscureNewAgainPass = !enableObscureNewAgainPass;
                }
              });
            },
            child: controller == passwordController
                ? enableObscureOldPass
                    ? SvgPicture.asset(
                        ImageConstant.REGISTER_LOGIN_OBSCURE_ENABLE_ICON,
                        color: AppColors.iconColor,
                      )
                    : SvgPicture.asset(
                        ImageConstant.REGISTER_LOGIN_OBSCURE_DISABLE_ICON,
                        color: AppColors.iconColor,
                      )
                : enableObscureNewAgainPass
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
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }

  TextFormField buildTextFormFieldNewPassword(String labelText) {
    return TextFormField(
      style: AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
      cursorColor: AppColors.cursorColor,
      onChanged: (value) {
        setState(() {
          isRulesVisible = true;
        });
      },
      inputFormatters: [
        //FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      controller: newPasswordController,
      obscureText: enableObscureNewPass,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 28.w),
        suffixIconConstraints: BoxConstraints.tightFor(
          width: 50.w,
          height: 60.h,
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(
            right: 25.w,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                enableObscureNewPass = !enableObscureNewPass;
              });
            },
            child: enableObscureNewPass
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
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28.w),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.change_password_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {
          SharedPrefs.setNewPassword(newPasswordController.text);
          SharedPrefs.setOldPassword(passwordController.text);
          if (passwordController.text.isNotEmpty &&
              newPasswordAgainController.text.isNotEmpty &&
              newPasswordController.text.isNotEmpty) {
            if (passwordController.text == newPasswordAgainController.text ||
                passwordController.text == newPasswordController.text) {
              Navigator.popAndPushNamed(
                  context, RouteConstant.CHANGE_PASSWORD_VERIFY);
            } else if (passwordController.text !=
                    newPasswordAgainController.text &&
                passwordController.text != newPasswordController.text &&
                newPasswordController.text == newPasswordAgainController.text) {
              Navigator.popAndPushNamed(
                  context, RouteConstant.CHANGE_PASSWORD_VERIFY);
            } else {
              showDialog(
                  context: context,
                  builder: (_) => CustomAlertDialogResetPassword(
                        description:
                            LocaleKeys.change_password_popup_text_fail.locale,
                        onPressed: () => Navigator.popAndPushNamed(
                            context, RouteConstant.CHANGE_PASSWORD_VIEW),
                      ));
            }
          } else {
            showDialog(
                context: context,
                builder: (_) => CustomAlertDialogResetPassword(
                      description:
                          LocaleKeys.change_password_popup_text_fail.locale,
                      onPressed: () => Navigator.popAndPushNamed(
                          context, RouteConstant.CHANGE_PASSWORD_VIEW),
                    ));
          }
        },
      ),
    );
  }
}

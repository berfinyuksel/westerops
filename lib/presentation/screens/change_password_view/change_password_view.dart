import 'package:dongu_mobile/logic/cubits/user_auth_cubit/user_auth_cubit.dart';
import 'package:dongu_mobile/presentation/screens/register_view/components/password_rules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../register_view/components/clipped_password_rules.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                top: context.dynamicHeight(0.02),
                bottom: context.dynamicHeight(0.02),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [buildTextFields(), buildButton(context)],
              ),
            ),
            Positioned(
              top: context.height > 800 ? context.dynamicHeight(0.03) : context.dynamicHeight(0.125),
              left: context.dynamicWidht(0.365),
              right: context.dynamicWidht(0.365),
              child: Visibility(visible: isRulesVisible, child: ClippedPasswordRules( child: PasswordRules(passwordController: passwordController),)),
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
            height: context.dynamicHeight(0.01),
          ),
          buildTextFormFieldPassword(LocaleKeys.change_password_current_password.locale, passwordController),
          buildTextFormFieldNewPassword(LocaleKeys.change_password_new_password.locale),
          buildTextFormFieldPassword(LocaleKeys.change_password_new_password_again.locale, newPasswordAgainController)
        ],
      ),
    );
  }

  TextFormField buildTextFormFieldPassword(String labelText, TextEditingController controller) {
    return TextFormField(
      style: AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
      cursorColor: AppColors.cursorColor,
      onTap: () {
        setState(() {
          isRulesVisible = false;
        });
      },
      controller: controller,
      obscureText: controller == passwordController ? enableObscureOldPass : enableObscureNewAgainPass,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
        suffixIconConstraints: BoxConstraints.tightFor(width: context.dynamicWidht(0.12), height: context.dynamicWidht(0.06)),
        suffixIcon: Padding(
          padding: EdgeInsets.only(
            right: context.dynamicWidht(0.06),
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
      controller: newPasswordController,
      obscureText: enableObscureNewPass,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
        suffixIconConstraints: BoxConstraints.tightFor(
          width: context.dynamicWidht(0.12),
          height: context.dynamicWidht(0.06),
        ),
        suffixIcon: Padding(
          padding: EdgeInsets.only(
            right: context.dynamicWidht(0.06),
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
      padding: EdgeInsets.only(left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.change_password_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: (){
           context.read<UserAuthCubit>().changePassword(
                passwordController.text,
                newPasswordController.text
              );
        },
      ),
    );
  }
}

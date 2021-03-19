import 'package:dongu_mobile/presentation/screens/register_view/components/clipped_password_rules.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        title: "Şifre Değişikliği",
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
              child: Visibility(visible: isRulesVisible, child: ClippedPasswordRules(passwordController: newPasswordController)),
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
          buildTextFormFieldPassword("Mevcut Şifre", passwordController),
          buildTextFormFieldNewPassword("Yeni Şifre"),
          buildTextFormFieldPassword("Yeni Şifre Tekrar", newPasswordAgainController)
        ],
      ),
    );
  }

  TextFormField buildTextFormFieldPassword(String labelText, TextEditingController controller) {
    return TextFormField(
      onTap: () {
        setState(() {
          isRulesVisible = false;
        });
      },
      controller: controller,
      obscureText: controller == passwordController ? enableObscureOldPass : enableObscureNewAgainPass,
      decoration: InputDecoration(
        suffixIconConstraints: BoxConstraints.tightFor(width: context.dynamicWidht(0.05), height: context.dynamicHeight(0.02)),
        suffixIcon: GestureDetector(
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
                    )
                  : SvgPicture.asset(
                      ImageConstant.REGISTER_LOGIN_OBSCURE_DISABLE_ICON,
                    )
              : enableObscureNewAgainPass
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
      onChanged: (value) {
        setState(() {
          isRulesVisible = true;
        });
      },
      controller: newPasswordController,
      obscureText: enableObscureNewPass,
      decoration: InputDecoration(
        suffixIconConstraints: BoxConstraints.tightFor(width: context.dynamicWidht(0.05), height: context.dynamicHeight(0.02)),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              enableObscureNewPass = !enableObscureNewPass;
            });
          },
          child: enableObscureNewPass
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
        title: "Kaydet",
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
      ),
    );
  }
}

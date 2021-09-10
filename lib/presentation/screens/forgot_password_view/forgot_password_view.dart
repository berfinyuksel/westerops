import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/user_auth_cubit/user_auth_cubit.dart';
import 'package:dongu_mobile/presentation/screens/home_page_view/home_page_view.dart';
import 'package:dongu_mobile/presentation/screens/login_view/login_view.dart';
import 'package:dongu_mobile/presentation/screens/register_view/components/password_rules.dart';
import 'package:dongu_mobile/presentation/screens/surprise_pack_view/components/custom_alert_dialog.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants/image_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import '../register_view/components/clipped_password_rules.dart';
import 'components/popup_successfully_changed.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool enableObscure = true;
  bool isCodeSent = false;
  String dropdownValue = "TR";
  bool isRulesVisible = false;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  String? verificationId;
  bool showLoading = false;
  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      print(authCredential.user!.providerData);
      setState(() {
        showLoading = false;
      });
      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginView()));
        //Navigator.pushNamed(context, RouteConstant.LOGIN_VIEW);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isRulesVisible) {
            isRulesVisible = false;
          }
        });
      },
      child: CustomScaffold(
        title: "Şifremi Unuttum",
        body: Stack(
          children: [
            Padding(
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
                        width: context.dynamicWidht(0.64),
                        color: Colors.white,
                        child: buildTextFormField(
                            LocaleKeys.forgot_password_phone.locale,
                            phoneController),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.dynamicHeight(0.02),
                  ),
                  Visibility(
                      visible: isCodeSent,
                      child: Container(
                          color: Colors.white,
                          child: buildTextFormField(
                              LocaleKeys.forgot_password_activation_code.locale,
                              codeController))),
                  Visibility(
                    visible: isCodeSent,
                    child: SizedBox(
                      height: context.dynamicHeight(0.02),
                    ),
                  ),
                  Visibility(
                      visible: isCodeSent,
                      child: Container(
                          color: Colors.white,
                          child: buildTextFormFieldPassword(
                              LocaleKeys.forgot_password_new_password.locale))),
                  SizedBox(
                    height: context.dynamicHeight(0.02),
                  ),
                  CustomButton(
                    onPressed: () async {
                      if (isCodeSent == true) {
                        showDialog(
                            context: context,
                            builder: (_) =>
                                CustomAlertDialogSuccessfullyChangedPassword());
                      }
                      String phoneTR = '+90' + phoneController.text;
                      String phoneEN = '+1' + phoneController.text;

                      await _auth.verifyPhoneNumber(
                          phoneNumber:
                              dropdownValue == 'TR' ? phoneTR : phoneEN,
                          verificationCompleted: (phoneAuthCredential) async {
                            setState(() {
                              showLoading = false;
                            });
                            //signInWithPhoneAuthCredential(phoneAuthCredential);
                          },
                          verificationFailed: (verificationFailed) async {
                            setState(() {
                              showLoading = false;
                            });
                            // ignore: deprecated_member_use
                          },
                          codeSent: (verificationId, resendingToken) async {
                            setState(() {
                              showLoading = false;
                              currentState =
                                  MobileVerificationState.SHOW_OTP_FORM_STATE;
                              this.verificationId = verificationId;
                            });
                          },
                          codeAutoRetrievalTimeout: (verificationId) async {});
                      setState(() {
                        isCodeSent = true;
                        showLoading = true;
                        print( _auth.app.options);//session_key

                        /*FirebaseAuth.instance.sendPasswordResetEmail(
                            email: phoneController.text);*/
                      });
                      if (codeController.text.isNotEmpty) {
                        PhoneAuthCredential phoneAuthCredential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId.toString(),
                                smsCode: codeController.text);
                        signInWithPhoneAuthCredential(phoneAuthCredential);

                        context.read<UserAuthCubit>().resetPassword(
                            passwordController.text, phoneController.text);
                      }
                    },
                    width: double.infinity,
                    title: isCodeSent
                        ? LocaleKeys.forgot_password_reset_password
                        : LocaleKeys.forgot_password_send_code,
                    color: isCodeSent
                        ? AppColors.disabledButtonColor
                        : AppColors.greenColor,
                    borderColor: isCodeSent
                        ? AppColors.disabledButtonColor
                        : AppColors.greenColor,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: context.dynamicHeight(0.02),
                  ),
                  buildVisibilitySendAgainCode,
                ],
              ),
            ),
            /*CustomButton(
              title: "verify",
              color: Colors.red,
              textColor: Colors.white,
              borderColor: Colors.red,
              width: 120,
              onPressed: () async {
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationId.toString(),
                        smsCode: codeController.text);
                signInWithPhoneAuthCredential(phoneAuthCredential);
              },*/
            Positioned(
              top: context.height > 800
                  ? context.dynamicHeight(0.1)
                  : context.dynamicHeight(0.125),
              left: context.dynamicWidht(0.365),
              right: context.dynamicWidht(0.365),
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
          TextButton(
            onPressed: () async {
              await _auth.verifyPhoneNumber(
                  phoneNumber: phoneController.text,
                  verificationCompleted: (phoneAuthCredential) async {
                    setState(() {
                      showLoading = false;
                    });
                    //signInWithPhoneAuthCredential(phoneAuthCredential);
                  },
                  verificationFailed: (verificationFailed) async {
                    setState(() {
                      showLoading = false;
                    });
                    // ignore: deprecated_member_use
                  },
                  codeSent: (verificationId, resendingToken) async {
                    setState(() {
                      showLoading = false;

                      currentState =
                          MobileVerificationState.SHOW_OTP_FORM_STATE;
                      this.verificationId = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationId) async {});
              setState(() {
                isCodeSent = true;
                showLoading = true;
                /*FirebaseAuth.instance.sendPasswordResetEmail(
                            email: phoneController.text);*/
              });
            },
            child: LocaleText(
              text: LocaleKeys.forgot_password_send_again,
              style: AppTextStyles.bodyTextStyle,
              alignment: TextAlign.center,
            ),
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

  TextFormField buildTextFormFieldPassword(String labelText) {
    return TextFormField(
      cursorColor: AppColors.cursorColor,
      style: AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
      onChanged: (value) {
        setState(() {
          isRulesVisible = true;
        });
      },
      controller: passwordController,
      obscureText: enableObscure,
      decoration: InputDecoration(
        suffixIconConstraints: BoxConstraints.tightFor(
            width: context.dynamicWidht(0.09),
            height: context.dynamicWidht(0.06)),
        suffixIcon: Padding(
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

  TextFormField buildTextFormField(
      String labelText, TextEditingController controller) {
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
            AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w700),
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

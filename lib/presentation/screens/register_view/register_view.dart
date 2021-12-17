import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';

import 'package:dongu_mobile/presentation/screens/forgot_password_view/forgot_password_view.dart';
import 'package:dongu_mobile/presentation/screens/register_view/components/error_alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/services/auth_service.dart';
import '../../../data/services/facebook_login_controller.dart';
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
import 'components/clipped_password_rules.dart';
import 'components/consent_text.dart';
import 'components/contract_text.dart';
import 'components/password_rules.dart';
import 'components/sign_with_social_auth.dart';
import 'package:validators/validators.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
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
      body: GestureDetector(
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
              top: context.dynamicHeight(0.06),
              left: 0,
              child: IconButton(
                icon: SvgPicture.asset(ImageConstant.BACK_ICON,
                    color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              bottom: -10,
              left: context.dynamicWidht(0.035),
              right: context.dynamicWidht(0.035),
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
    );
  }

  Padding buildCardBody(BuildContext context) {
    String phoneTR = '+90' + phoneController.text;
    //String phoneEN = '+1' + phoneController.text;

    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom * 0.65),
      child: Container(
        padding: EdgeInsets.only(
          bottom: context.dynamicHeight(0.02),
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
            Spacer(
              flex: 2,
            ),
            LocaleText(
              text: LocaleKeys.register_text_register,
              maxLines: 1,
              style: AppTextStyles.appBarTitleStyle,
            ),
            Spacer(
              flex: 2,
            ),
            Divider(
              height: 0,
              thickness: 4,
              color: AppColors.borderAndDividerColor,
            ),
            Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.06)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildDropDown(context),
                    Container(
                      height: context.dynamicHeight(0.06),
                      width: context.dynamicWidht(0.57),
                      child: buildTextFormField(
                          LocaleKeys.register_phone.locale,
                          phoneController,
                          (val) => !isNumeric(phoneController.text)
                              ? "Invalid Phone"
                              : null),
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
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.06)),
                child: buildTextFormField(LocaleKeys.register_full_name.locale,
                    nameController, (value) {}),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.06)),
                child: buildTextFormField(
                    LocaleKeys.register_email.locale,
                    emailController,
                    (val) =>
                        isEmail(emailController.text) ? "Invalid Email" : null),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.06)),
                child: buildTextFormFieldPassword(
                    LocaleKeys.register_password.locale),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
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
                color: checkboxValue
                    ? AppColors.greenColor
                    : AppColors.disabledButtonColor,
                borderColor: checkboxValue
                    ? AppColors.greenColor
                    : AppColors.disabledButtonColor,
                onPressed: () async {
                  bool numberControl =
                      passwordController.text.contains(RegExp(r'[0-9]'));
                  bool uppercaseControl =
                      passwordController.text.contains(RegExp(r'[A-Z]'));
                  bool lengthControl = passwordController.text.length > 7;
                  bool phoneControl = phoneTR.length >= 13;
                  String firstName = nameController.text;
                  String lastName = nameController.text;
                  firstName.split(" ");
                  lastName.split(" ");
                  print(firstName);
                  print(lastName);
                  if (lengthControl ||
                      nameController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      uppercaseControl ||
                      phoneControl ||
                      numberControl || firstName.isEmpty ||lastName.isEmpty ||nameController.text.isEmpty) {
                    _showMyDialog();
                  }
                  if (checkboxValue &&
                      numberControl &&
                      uppercaseControl &&
                      lengthControl &&
                      phoneControl) {
             
                    context.read<UserAuthCubit>().registerUser(
                        firstName,
                        lastName,
                        emailController.text,
                        phoneTR,
                        passwordController.text);
                    String phoneEN = '+1' + phoneController.text;

                    if (nameController.text.isNotEmpty &&
                        phoneController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty &&
                        lastName.isNotEmpty &&
                        firstName.isNotEmpty) {
                      Navigator.popAndPushNamed(
                          context, RouteConstant.SMS_VERIFY_VIEW);
                      await _auth.verifyPhoneNumber(
                          phoneNumber:
                              dropdownValue == 'TR' ? phoneTR : phoneEN,
                          verificationCompleted: (phoneAuthCredential) async {
                            // print(
                            //     "SMS CODE : ${phoneAuthCredential.smsCode}");
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

                      // showDialog(
                      //     context: context,
                      //     builder: (_) => CustomAlertDialogResetPassword(
                      //         description: "Hoş Geldiniz",
                      //         onPressed: () => Navigator.popAndPushNamed(
                      //             context, RouteConstant.SMS_VERIFY_VIEW)));

                    } else {
                      _showMyDialog();
                    }
                  } else {
                    _showMyDialog();
                  }
                }),
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
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final GenericState state = context.watch<UserAuthCubit>().state;
        if (state is GenericInitial) {
          return Container();
        } else if (state is GenericLoading) {
          return Container();
        } else if (state is GenericCompleted) {
          return AlertDialog(
            title: Text('Hosgeldiniz'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          return ErrorAlertDialog(onTap: () {});
        }
      },
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
          GestureDetector(
            onTap: () {
              AuthService().loginWithGmail();
              Navigator.of(context).pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
            },
            child: SignWithSocialAuth(
              image: ImageConstant.REGISTER_LOGIN_GOOGLE_ICON,
            ),
          ),
          GestureDetector(
            onTap: () {
              FacebookSignInController().login();
              Navigator.of(context).pushNamed(RouteConstant.CUSTOM_SCAFFOLD);
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
      height: context.dynamicHeight(1.15),
      width: context.dynamicWidht(1),
      decoration: BoxDecoration(),
      child: SvgPicture.asset(
        ImageConstant.REGISTER_BACKGROUND,
        fit: BoxFit.cover,
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

  TextFormField buildTextFormField(String labelText,
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
      inputFormatters: [
        //FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
        FilteringTextInputFormatter.singleLineFormatter,
      ], // On
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
    );
  }
}

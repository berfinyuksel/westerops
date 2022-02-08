import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/notification_cubit.dart';
import 'package:dongu_mobile/presentation/screens/login_view/components/error_dialog_for_login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';
import 'dart:io' show Platform;

import '../../../data/services/auth_service.dart';
import '../../../data/services/facebook_login_controller.dart';
import '../../../data/shared/shared_prefs.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';
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
  String? token;
  void notificationToken() async {
    token = await FirebaseMessaging.instance.getToken();
    print("TOKEN REG : $token");
  }

  @override
  void initState() {
    super.initState();
    notificationToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
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
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () =>
                    Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 15.w,
              right: 15.w,
              child: buildCardBody(context),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView buildCardBody(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.only(
            bottom: 20.h,
          ),
          height: 503.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(18.0.h),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(height: 21.h),
              LocaleText(
                text: LocaleKeys.login_text_login,
                maxLines: 1,
                style: AppTextStyles.appBarTitleStyle,
              ),
              SizedBox(height: 19.5.h),
              Divider(
                thickness: 4,
                height: 0,
                color: AppColors.borderAndDividerColor,
              ),
              SizedBox(height: 20.5.h),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 28.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildDropDown(context),
                      Container(
                        height: 56.h,
                        width: 245.w,
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
              SizedBox(height: 20.h),
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 28.w,
                  ),
                  child: buildTextFormField(LocaleKeys.register_password.locale,
                      passwordController, (val) {}),
                ),
              ),
              SizedBox(height: 26.h),
              CustomButton(
                width: 176.w,
                title: LocaleKeys.login_text_login,
                textColor: Colors.white,
                color: AppColors.greenColor,
                borderColor: AppColors.greenColor,
                onPressed: () async {
                  String phoneTR = '+90' + phoneController.text;
                  bool lengthControl = passwordController.text.length > 7;
                  bool phoneControl = phoneTR.length >= 13;
                  //String phoneEN = '+1' + phoneController.text;
                  if (lengthControl ||
                      phoneControl ||
                      passwordController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    _showMyDialog();
                  }
                  await context
                      .read<UserAuthCubit>()
                      .loginUser(phoneTR, passwordController.text);
                  _showMyDialog();
                  if (SharedPrefs.getIsLogined) {
                    if (Platform.isAndroid) {
                      context
                          .read<NotificationCubit>()
                          .postNotification(token!, "android");
                      print("Platform.isAndroid" + token!);
                    } else if (Platform.isIOS) {
                      context
                          .read<NotificationCubit>()
                          .postNotification(token!, "ios");
                      // iOS-specific code
                    }
                  }
                  if (SharedPrefs.getIsLogined) {
                    Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
                  }
                },
              ),
              SizedBox(height: 16.h),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, RouteConstant.FORGOT_PASSWORD_VIEW);
                },
                child: LocaleText(
                  text: LocaleKeys.login_forgot_pass,
                  style: AppTextStyles.bodyTextStyle,
                  maxLines: 1,
                ),
              ),
              SizedBox(height: 32.h),
              Expanded(
                flex: 4,
                child: buildSocialAuths(context),
              ),
              SizedBox(height: 48.h),
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
                          Navigator.pushNamed(
                              context, RouteConstant.REGISTER_VIEW);
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
              SizedBox(height: 42.h),
            ],
          ),
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
          print(state.response);
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.04)),
              width: context.dynamicWidht(0.87),
              height: context.dynamicHeight(0.29),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Spacer(
                    flex: 8,
                  ),
                  SvgPicture.asset(
                    ImageConstant.SURPRISE_PACK,
                    height: context.dynamicHeight(0.134),
                  ),
                  SizedBox(height: 10),
                  Text(
                    LocaleKeys.login_login_success_alert_dialog_text.locale,
                    style: AppTextStyles.bodyBoldTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  Spacer(
                    flex: 35,
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RouteConstant.CUSTOM_SCAFFOLD);
                    },
                    width: context.dynamicWidht(0.35),
                    color: AppColors.greenColor,
                    textColor: Colors.white,
                    borderColor: AppColors.greenColor,
                    title: LocaleKeys.order_received_button_2.locale,
                  ),
                  Spacer(
                    flex: 20,
                  ),
                ],
              ),
            ),
          );
        } else {
          return ErrorAlertDialogForLogin();
        }
      },
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
      height: context.dynamicHeight(1),
      width: context.dynamicWidht(1),
      decoration: BoxDecoration(),
      child: SvgPicture.asset(
        ImageConstant.LOGIN_BACKGROUND,
        fit: BoxFit.cover,
      ),
    );
  }

  Container buildDropDown(BuildContext context) {
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

  TextFormField buildTextFormField(String labelText,
      TextEditingController controller, String? Function(String?)? validator) {
    String phoneTR = '+90';
    String phoneEN = '+1';
    return TextFormField(
      keyboardType: controller == phoneController
          ? TextInputType.number
          : TextInputType.visiblePassword,
      //  focusNode: FocusScope.of(context).focusedChild!.children.first,
      validator: validator,
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

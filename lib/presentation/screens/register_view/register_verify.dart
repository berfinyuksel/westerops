import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/user_auth_cubit/user_auth_cubit.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/components/popup_reset_password.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/forgot_password_view.dart';
import 'package:dongu_mobile/presentation/screens/register_view/components/error_alert_dialog.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class RegisterVerify extends StatefulWidget {
  const RegisterVerify({Key? key}) : super(key: key);

  @override
  _RegisterVerifyState createState() => _RegisterVerifyState();
}

class _RegisterVerifyState extends State<RegisterVerify> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showLoading = false;
  PhoneAuthCredential? phoneAuthCredential;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  TextEditingController codeController = TextEditingController();
  String? verificationId;
  String? userPhoneNumber;
  void sendCode(phoneAuthCredential) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: SharedPrefs.getUserPhone,
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
            currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
            this.verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  // String? userName;
  // String? userLastName;
  // String? userPhone;
  // String? userEmail;
  // String? userPassword;
  @override
  void initState() {
    userPhoneNumber = SharedPrefs.getUserPhone;
    sendCode(phoneAuthCredential);
    // userName = SharedPrefs.getUserName;
    // userLastName = SharedPrefs.getUserLastName;
    // userPhone = SharedPrefs.getUserPhone;
    // userEmail = SharedPrefs.getUserEmail;
    // userPassword = SharedPrefs.getUserPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(ImageConstant.BACK_ICON),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 170.w),
            child: SvgPicture.asset(ImageConstant.COMMONS_APP_BAR_LOGO),
          ),
        ],
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(flex: 5),
          buildText(context),
          Spacer(flex: 4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.w),
            child: Pinput(
              controller: codeController,
              length: 6,
              onCompleted: (pin) => print(pin),
              defaultPinTheme: PinTheme(
                width: 56,
                height: 50,
                textStyle: TextStyle(
                    fontSize: 20,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greenColor),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Spacer(flex: 3),
          Center(child: buildButton(context)),
          Spacer(flex: 3),
          Center(child: buildBottomTextAndIcon(context)),
          Spacer(flex: 40),
        ],
      ),
    );
  }

  Container buildText(BuildContext context) {
    String? phoneNumber = userPhoneNumber!;
    List<String> phoneNumberList = phoneNumber.split("").toList();
    List<String> lastTwoDigitList = [];
    int phoneLength = phoneNumberList.length;
    lastTwoDigitList.add(phoneNumberList[phoneLength - 2]);
    lastTwoDigitList.add(phoneNumberList[phoneLength - 1]);
    String lastTwoDigits = lastTwoDigitList.join("");
    return Container(
      child: Column(
        children: [
          Center(
            child: LocaleText(
              text: LocaleKeys.sms_verify_text_1,
              style: GoogleFonts.montserrat(
                fontSize: 18.0.sp,
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 37.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 28.w),
            child: Text.rich(
              TextSpan(children: [
                TextSpan(text: "***" + lastTwoDigits),
                TextSpan(
                  text: LocaleKeys.sms_verify_text_2.locale,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 28.w, right: 28.w),
      child: CustomButton(
        width: 372.w,
        title: LocaleKeys.sms_verify_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () async {
          print("Code controller: $codeController");
          // if (verificationId == null) {
          //     showDialog(
          //     context: context,
          //     builder: (_) => CustomErrorPopup(
          //       textMessage:
          //           "Telefon numarası veya SMS kodu hatalı. \nLütfen tekrar deneyiniz",
          //       buttonOneTitle: "Tamam",
          //       buttonTwoTittle: LocaleKeys.address_address_approval,
          //       imagePath: ImageConstant.COMMONS_WARNING_ICON,
          //       onPressedOne: () {
          //           Navigator.popAndPushNamed(
          //             context, RouteConstant.REGISTER_VIEW);
          //       },
          //     ),
          //   );
          // }
          if (verificationId!.isNotEmpty && userPhoneNumber!.isNotEmpty) {
            final AuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId!,
              smsCode: codeController.text,
            );
            try {
              await FirebaseAuth.instance.signInWithCredential(credential);
              context.read<UserAuthCubit>().registerUser(
                  SharedPrefs.getUserName,
                  SharedPrefs.getUserLastName,
                  SharedPrefs.getUserEmail,
                  SharedPrefs.getUserPhone,
                  SharedPrefs.getUserPassword);
              _showMyDialog();
            } on FirebaseAuthException catch (e) {
              if (e.code == 'invalid-verification-code') {
                showDialog(
                    context: context,
                    builder: (_) => CustomAlertDialogResetPassword(
                          description: LocaleKeys.forgot_password_fail_changed,
                          onPressed: () => Navigator.pop(context),
                        ));
              }
              showDialog(
                  context: context,
                  builder: (_) => CustomAlertDialogResetPassword(
                        description: LocaleKeys.forgot_password_fail_changed,
                        onPressed: () => Navigator.pop(context),
                      ));
            } catch (e) {
              showDialog(
                  context: context,
                  builder: (_) => CustomAlertDialogResetPassword(
                        description: LocaleKeys.forgot_password_fail_changed,
                        onPressed: () => Navigator.pop(context),
                      ));
            }
          } else {
            showDialog(
                context: context,
                builder: (_) => CustomAlertDialogResetPassword(
                      description: LocaleKeys.forgot_password_fail_changed,
                      onPressed: () => Navigator.pop(context),
                    ));
          }
        },
      ),
    );
  }

  GestureDetector buildBottomTextAndIcon(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _auth.verifyPhoneNumber(
            phoneNumber: userPhoneNumber ?? SharedPrefs.getUserPhone,
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
                currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                this.verificationId = verificationId;
              });
            },
            codeAutoRetrievalTimeout: (verificationId) async {});
      },
      child: Container(
        height: 25.h,
        width: 180.w,
        child: Row(
          children: [
            SvgPicture.asset(
              ImageConstant.SMS_OTP_VERIFY_RESEND_CODE_ICON,
            ),
            SizedBox(width: 8.w),
            LocaleText(
              text: LocaleKeys.sms_verify_text_3,
              style: GoogleFonts.montserrat(
                fontSize: 14.0.sp,
                color: AppColors.textColor,
              ),
              alignment: TextAlign.center,
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
          return Center(
              child: Container(child: CustomCircularProgressIndicator()));
        } else if (state is GenericLoading) {
          return Center(
              child: Container(child: CustomCircularProgressIndicator()));
        } else if (state is GenericCompleted) {
          return CustomAlertDialogResetPassword(
            description: "Başarılı bir şekilde Döngü'ye üye oldunuz.",
            onPressed: () => Navigator.popAndPushNamed(
                context, RouteConstant.CUSTOM_SCAFFOLD),
          );
        } else {
          return ErrorAlertDialog(onTap: () {});
        }
      },
    );
  }
}

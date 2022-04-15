import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/user_auth_cubit/user_auth_cubit.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/components/popup_reset_password.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/forgot_password_view.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
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

import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';

class VerifyInformation extends StatefulWidget {
  const VerifyInformation({Key? key}) : super(key: key);

  @override
  _VerifyInformationState createState() => _VerifyInformationState();
}

class _VerifyInformationState extends State<VerifyInformation> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool showLoading = false;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  PhoneAuthCredential? phoneAuthCredential;
  String? verificationId;
  String? userPhoneNumber;
  TextEditingController codeController = TextEditingController();
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

  @override
  void initState() {
    userPhoneNumber = SharedPrefs.getUserPhone;
    sendCode(phoneAuthCredential);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //  automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset(ImageConstant.BACK_ICON),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: context.dynamicWidht(0.4)),
            child: SvgPicture.asset(ImageConstant.COMMONS_APP_BAR_LOGO),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: context.dynamicHeight(0.02),
          bottom: context.dynamicHeight(0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 10),
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
            buildButton(context),
            Spacer(flex: 5),
            buildBottomTextAndIcon(context),
            Spacer(flex: 100),
          ],
        ),
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
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.1)),
      child: Column(
        children: [
          LocaleText(
            text: LocaleKeys.sms_verify_text_1,
            style: GoogleFonts.montserrat(
              fontSize: 18.0,
              color: AppColors.orangeColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: context.dynamicHeight(0.05)),
          Text.rich(
            TextSpan(children: [
              TextSpan(text: "***" + lastTwoDigits),
              TextSpan(
                text: LocaleKeys.sms_verify_text_2.locale,
              ),
            ]),
          ),
        ],
      ),
    );
  }

  update() {
    context.read<UserAuthCubit>().updateUser(
        SharedPrefs.getUserName,
        SharedPrefs.getUserLastName,
        SharedPrefs.getUserEmail,
        SharedPrefs.getUserPhone,
        SharedPrefs.getUserPassword,
        SharedPrefs.getUserBirth
        // birthController.text,
        );
  }
  errorPopup(){
         showDialog(
                    context: context,
                    builder: (_) => CustomAlertDialogResetPassword(
                          description: LocaleKeys.forgot_password_fail_changed,
                          onPressed: () => Navigator.pop(context),
                        ));
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.sms_verify_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () async {
          if (verificationId!.isNotEmpty && userPhoneNumber!.isNotEmpty) {
            final AuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId!,
              smsCode: codeController.text,
            );
            try {
              await FirebaseAuth.instance.signInWithCredential(credential);
              update();
              _showMyDialog();
            } on FirebaseAuthException catch (e) {
              if (e.code == 'invalid-verification-code') {
                errorPopup();
              }
              errorPopup();
            } catch (e) {
                errorPopup();
            }
          } else {
                errorPopup();
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
        height: context.dynamicHeight(0.053),
        width: context.dynamicWidht(0.91),
        child: Padding(
          padding: EdgeInsets.only(left: context.dynamicWidht(0.30)),
          child: Row(
            children: [
              SvgPicture.asset(
                ImageConstant.SMS_OTP_VERIFY_RESEND_CODE_ICON,
              ),
              SizedBox(width: context.dynamicWidht(0.011)),
              LocaleText(
                text: LocaleKeys.sms_verify_text_3,
                style: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  color: AppColors.textColor,
                ),
                alignment: TextAlign.center,
              ),
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
          return buildUpdateCompletedAlertDialog(context);
        } else {
          return buildUpdateErrorAlertDialog(context);
        }
      },
    );
  }

  AlertDialog buildUpdateErrorAlertDialog(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.04)),
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
              ImageConstant.COMMONS_WARNING_ICON,
              height: context.dynamicHeight(0.134),
            ),
            SizedBox(height: 10.h),
            Text(
              "Bu e-postaya veya telefon numarasına sahip kullanıcı var.",
              style: AppTextStyles.bodyBoldTextStyle,
              textAlign: TextAlign.center,
            ),
            Spacer(
              flex: 35,
            ),
            CustomButton(
              onPressed: () {
                Navigator.pop(context);
              },
              width: 110.w,
              color: AppColors.greenColor,
              textColor: Colors.white,
              borderColor: AppColors.greenColor,
              title: "Tamam",
            ),
            Spacer(
              flex: 20,
            ),
          ],
        ),
      ),
    );
  }

  AlertDialog buildUpdateCompletedAlertDialog(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.04)),
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
            SizedBox(height: 10.h),
            Text(
              "Değişiklikler başarılı bir şekilde güncellendi.",
              style: AppTextStyles.bodyBoldTextStyle,
              textAlign: TextAlign.center,
            ),
            Spacer(
              flex: 35,
            ),
            CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
              },
              width: 110.w,
              color: AppColors.greenColor,
              textColor: Colors.white,
              borderColor: AppColors.greenColor,
              title: LocaleKeys.order_received_button_2,
            ),
            Spacer(
              flex: 20,
            ),
          ],
        ),
      ),
    );
  }
}

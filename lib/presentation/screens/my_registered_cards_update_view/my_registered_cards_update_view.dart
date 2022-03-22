import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_card_repository.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/components/popup_reset_password.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/extensions/context_extension.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';

class MyRegisteredCardsUpdateView extends StatefulWidget {
  const MyRegisteredCardsUpdateView({
    Key? key,
  }) : super(key: key);
  @override
  _MyRegisteredCardsUpdateViewState createState() =>
      _MyRegisteredCardsUpdateViewState();
}

class _MyRegisteredCardsUpdateViewState
    extends State<MyRegisteredCardsUpdateView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  String yearValueForInput = "";
  String monthValueForInput = "";

  final monthsList = [
    "  01",
    "  02",
    "  03",
    "  04",
    "  05",
    "  06",
    "  07",
    "  08",
    "  09",
    "  10",
    "  11",
    "  12",
  ];

  final yearsList = [
    "  2021",
    "  2022",
    "  2023",
    "  2024",
    "  2025",
    "  2026",
    "  2027",
    "  2028",
    "  2029",
    "  2030",
    "  2031",
    "  2032",
    "  2033",
    "  2034",
    "  2035",
  ];

  String? monthValue;
  String? yearValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: CustomScaffold(
        title: LocaleKeys.custom_drawer_body_list_tile_cards,
        body: Padding(
          padding:
              EdgeInsets.only(left: 28.w, right: 28.w, top: 20.h, bottom: 29.h),
          child: SingleChildScrollView(
            child: Container(
              height: 748.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocaleText(
                    text: LocaleKeys.registered_cards_button,
                    style: AppTextStyles.bodyTitleStyle,
                  ),
                  SizedBox(height: 10.h),
                  //buildDropDown(context),
                  buildTextFormField(
                      LocaleKeys.payment_payment_name_on_card.locale,
                      nameController),
                  SizedBox(height: 20.h),
                  buildCardNumberTextFormField(
                      LocaleKeys.payment_payment_card_number.locale,
                      cardNumberController),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Container(
                        width: 95.w,
                        height: 56.h,
                        color: Colors.white,
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          hint: Padding(
                            padding: EdgeInsets.only(
                              left: 20.w,
                              right: 15.w,
                            ),
                            child: Text(
                              LocaleKeys.payment_payment_month_text.locale,
                            ),
                          ),
                          value: monthValue,
                          onChanged: (value) {
                            setState(() {
                              this.monthValue = value;
                            });
                          },
                          items: monthsList.map((String item) {
                            return DropdownMenuItem(
                              child: Text(item),
                              value: item,
                              onTap: () {
                                setState(() {
                                  monthValueForInput = item;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Container(
                        width: 95.w,
                        height: 56.h,
                        color: Colors.white,
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          hint: Padding(
                            padding: EdgeInsets.only(
                              left: 20.w,
                              right: 15.w,
                            ),
                            child: Text(
                              LocaleKeys.payment_payment_year_text.locale,
                            ),
                          ),
                          value: yearValue,
                          onChanged: (value) {
                            setState(() {
                              this.yearValue = value;
                            });
                          },
                          items: yearsList.map((String item) {
                            return DropdownMenuItem(
                              child: Text(item),
                              value: item,
                              onTap: () {
                                setState(() {
                                  yearValueForInput = item;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      // buildTextFormField("CVC/CVC2", cvvController),
                      buildCVVTextFormField("CVC/CVC2", cvvController)
                    ],
                  ),
                  SizedBox(height: 20.h),
                  buildTextFormField(
                      LocaleKeys.payment_payment_name_card.locale,
                      cardNameController),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(ImageConstant.IYZICO_LOGO),
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Text(
                          "Ödeme sistemimiz Iyzico\ntarafından sağlanmaktadır\nve işlem güvenliğiniz Iyzico\ngüvencesi altındadır.",
                          style: AppTextStyles.subTitleStyle,
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 4),
                  CustomButton(
                    width: double.infinity,
                    title: LocaleKeys.change_password_button,
                    color: AppColors.greenColor,
                    borderColor: AppColors.greenColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      var lastFourDigits = cardNumberController.text
                          .substring(cardNumberController.text.length - 4);
                      var binNumber = cardNumberController.text.substring(0, 6);
                      var cardNumberControl = binNumber + lastFourDigits;
                      if (SharedPrefs.getCardsList
                              .contains(cardNumberControl) ==
                          true) {
                        showDialog(
                            context: context,
                            builder: (_) => CustomAlertDialogResetPassword(
                                  description:
                                      "Kart numarası, kayıtlı kartlarınızdan farklı olmalıdır.",
                                  onPressed: () => Navigator.of(context).pop(),
                                ));
                      } else {
                        StatusCode statusCode = await sl<IyzicoCardRepository>()
                            .addCard(
                                cardNameController.text.toString(),
                                nameController.text.toString(),
                                cardNumberController.text.toString(),
                                monthValueForInput.toString(),
                                buildYearValue().toString());

                        switch (statusCode) {
                          case StatusCode.success:
                            showDialog(
                                context: context,
                                builder: (_) => CustomAlertDialogResetPassword(
                                      description: LocaleKeys
                                          .registered_cards_save_alert_dialog
                                          .locale,
                                      onPressed: () =>
                                          Navigator.popAndPushNamed(context,
                                              RouteConstant.CUSTOM_SCAFFOLD),
                                    ));
                            break;
                          case StatusCode.error:
                            showDialog(
                                context: context,
                                builder: (_) => CustomAlertDialogResetPassword(
                                      description: LocaleKeys
                                          .registered_cards_error_alert_dialog
                                          .locale,
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ));
                            break;
                          case StatusCode.unauthecticated:
                            showDialog(
                                context: context,
                                builder: (_) => CustomAlertDialogResetPassword(
                                      description: LocaleKeys
                                          .registered_cards_unauthorized_alert_dialog
                                          .locale,
                                      onPressed: () =>
                                          Navigator.popAndPushNamed(context,
                                              RouteConstant.LOGIN_VIEW),
                                    ));
                            break;
                          default:
                        }
                      }
                    },
                  ),
                  Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildTextFormField(
      String labelText, TextEditingController controller) {
    return Container(
      width: controller == cvvController ? 142.w : 372.w,
      height: 56.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderAndDividerColor, width: 0.4),
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      ),
      child: TextFormField(
        // maxLines:
        //     controller == cardNumberController || controller == yearController
        //         ? context.dynamicHeight(0.11).toInt()
        //         : context.dynamicHeight(0.06).toInt(),
        inputFormatters: [
          controller == nameController
              ? FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
              : FilteringTextInputFormatter.singleLineFormatter,
        ],
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.myInformationBodyTextStyle,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidht(0.03), vertical: 0),
          labelText: labelText,
          labelStyle: AppTextStyles.bodyTextStyle,
          // enabledBorder: InputBorder.none,
          // focusedBorder: InputBorder.none,
          // border: InputBorder.none,
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
      ),
    );
  }

  Container buildCVVTextFormField(
      String labelText, TextEditingController controller) {
    return Container(
      width: controller == cvvController ? 142.w : 372.w,
      height: 56.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderAndDividerColor, width: 0.4),
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      ),
      child: TextFormField(
        maxLength: 3,
        // maxLines:
        //     controller == cardNumberController || controller == yearController
        //         ? context.dynamicHeight(0.11).toInt()
        //         : context.dynamicHeight(0.06).toInt(),
        inputFormatters: [
          controller == nameController
              ? FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
              : FilteringTextInputFormatter.singleLineFormatter,
        ],
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.myInformationBodyTextStyle,
        controller: controller,
        decoration: InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidht(0.03), vertical: 0),
          labelText: labelText,
          labelStyle: AppTextStyles.bodyTextStyle,
          // enabledBorder: InputBorder.none,
          // focusedBorder: InputBorder.none,
          // border: InputBorder.none,
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
      ),
    );
  }

  Container buildCardNumberTextFormField(
      String labelText, TextEditingController controller) {
    return Container(
      width: 372.w,
      height: 56.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderAndDividerColor, width: 0.4),
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          //  FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
          FilteringTextInputFormatter.singleLineFormatter,
          LengthLimitingTextInputFormatter(16),
        ],
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.myInformationBodyTextStyle,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidht(0.03), vertical: 0),
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
      ),
    );
  }

  String buildYearValue() {
    List<String> temporaryList = yearValueForInput.split("").toList();
    List<String> lastTwoDigits = [];
    lastTwoDigits.add(temporaryList[temporaryList.length - 2]);
    lastTwoDigits.add(temporaryList[temporaryList.length - 1]);
    String lastTwoDigit = lastTwoDigits.join("");
    return lastTwoDigit;
  }
}

import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          padding: EdgeInsets.only(
              left: context.dynamicWidht(0.06),
              right: context.dynamicWidht(0.06),
              top: context.dynamicHeight(0.02),
              bottom: context.dynamicHeight(0.03)),
          child: SingleChildScrollView(
            child: Container(
              height: context.dynamicHeight(0.75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LocaleText(
                    text: LocaleKeys.registered_cards_button,
                    style: AppTextStyles.bodyTitleStyle,
                  ),
                  Spacer(flex: 2),
                  //buildDropDown(context),
                  buildTextFormField(
                      LocaleKeys.payment_payment_name_on_card.locale,
                      nameController),
                  Spacer(flex: 3),
                  buildTextFormField(
                      LocaleKeys.payment_payment_card_number.locale,
                      cardNumberController),
                  Spacer(flex: 3),
                  Row(
                    children: [
                      Container(
                        width: context.dynamicWidht(0.25),
                        height: context.dynamicHeight(0.06),
                        color: Colors.white,
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          hint: Padding(
                            padding: const EdgeInsets.fromLTRB(19, 0, 20, 0),
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
                            );
                          }).toList(),
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: context.dynamicWidht(0.23),
                        height: context.dynamicHeight(0.06),
                        color: Colors.white,
                        child: DropdownButton<String>(
                          underline: SizedBox(),
                          hint: Padding(
                            padding: const EdgeInsets.fromLTRB(19, 0, 20, 0),
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
                            );
                          }).toList(),
                        ),
                      ),
                      Spacer(),
                      buildTextFormField("CVV/CVV2", cvvController),
                    ],
                  ),
                  Spacer(flex: 3),
                  buildTextFormField(
                      LocaleKeys.payment_payment_name_card.locale,
                      cardNameController),
                  Spacer(
                    flex: 33,
                  ),
                  CustomButton(
                    width: double.infinity,
                    title: LocaleKeys.change_password_button,
                    color: AppColors.greenColor,
                    borderColor: AppColors.greenColor,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
      width: controller == cvvController
          ? context.dynamicWidht(0.31)
          : context.dynamicWidht(5.0),
      height: context.dynamicHeight(0.06),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderAndDividerColor, width: 2),
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
      ),
      child: TextFormField(
        // maxLines:
        //     controller == cardNumberController || controller == yearController
        //         ? context.dynamicHeight(0.11).toInt()
        //         : context.dynamicHeight(0.06).toInt(),
        inputFormatters: [
          //  FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.myInformationBodyTextStyle,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: context.dynamicWidht(0.05), vertical: 0),
            labelText: labelText,
            labelStyle: AppTextStyles.bodyTextStyle,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            border: InputBorder.none),
      ),
    );
  }
}

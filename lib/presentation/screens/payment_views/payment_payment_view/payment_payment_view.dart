import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/extensions/string_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/text/locale_text.dart';
import '../../../widgets/warning_container/warning_container.dart';

class PaymentPaymentView extends StatefulWidget {
  final bool? isOnline;

  const PaymentPaymentView({Key? key, this.isOnline}) : super(key: key);

  @override
  _PaymentPaymentViewState createState() => _PaymentPaymentViewState();
}

class _PaymentPaymentViewState extends State<PaymentPaymentView> {
  String dropdownMonthValue = "Ay";
  String dropdownYearValue = "Yıl";
  List<String> months = <String>['Ay', '01'];
  List<String> years = <String>['Yıl', '2021'];

  bool checkboxAddCardValue = false;

  String selectedCashOrCredit = "cash";
  int selectedIndex = 0;
  bool payWithAnotherCard = false;

  TextEditingController cardController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.48),
      child: ListView(
        children: [
          SizedBox(
            height: context.dynamicHeight(0.02),
          ),
          Visibility(
            visible: widget.isOnline!,
            child: buildOnline(context),
          ),
          Visibility(
            visible: !widget.isOnline!,
            child: buildDoor(context),
          ),
          //buildBottomCard(context),
        ],
      ),
    );
  }

  Column buildDoor(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
          child: LocaleText(
            text: LocaleKeys.payment_payment_pay_type,
            style: GoogleFonts.montserrat(
              fontSize: 16.0,
              color: AppColors.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        buildCashOrCreditListTile(
            context, LocaleKeys.payment_payment_cash, "cash"),
        buildCashOrCreditListTile(
            context, LocaleKeys.payment_payment_credit, "credit"),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        WarningContainer(
            text:
                "Ödeme şekliniz sipariş teslimatı\nesnasında kapıda değiştirilemez."),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        WarningContainer(
            text:
                "Ödemenizi size iletmiş olduğumuz\nsipariş numarasını restorana\ngöstererek yapınız."),
      ],
    );
  }

  ListTile buildCashOrCreditListTile(
      BuildContext context, String text, String cashOrCredit) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: text,
        style: AppTextStyles.myInformationBodyTextStyle,
      ),
      trailing: selectedCashOrCredit == cashOrCredit
          ? SvgPicture.asset(ImageConstant.REGISTER_LOGIN_PASSWORD_TICK)
          : null,
      onTap: () {
        setState(() {
          selectedCashOrCredit = cashOrCredit;
        });
      },
    );
  }

  Column buildOnline(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildBodyTitle(
          context,
          payWithAnotherCard
              ? LocaleKeys.payment_payment_pay_another_card
              : LocaleKeys.payment_payment_choose_card,
        ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        Visibility(
          visible: !payWithAnotherCard,
          child: Column(
            children: [
              Column(children: buildCards()),
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
            ],
          ),
        ),
        Visibility(
          visible: payWithAnotherCard,
          child: Column(
            children: [
              buildPayWithAnotherCard(context),
              Visibility(
                visible: checkboxAddCardValue,
                child: Column(
                  children: [
                    buildTextFormField(LocaleKeys.payment_payment_name_card,
                        cardNameController),
                    SizedBox(
                      height: context.dynamicHeight(0.02),
                    ),
                  ],
                ),
              ),
              buildRowCheckBox(context),
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
            ],
          ),
        ),
        payWithAnotherCard
            ? Padding(
                padding:
                    EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(ImageConstant.IYZICO_LOGO),
                    Text(
                      "Ödeme sistemimiz iyzico tarafından \nSağlanmaktadır ve işlem güvenliğiniz\nİyzico güvencesi altındadır.",
                      style: AppTextStyles.subTitleStyle,
                    ),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.dynamicWidht(0.065),
                    vertical: context.dynamicHeight(0.02)),
                child: SvgPicture.asset(ImageConstant.CARDS_COMPANY),
              ),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
        buildAnotherCardButton(context),
      ],
    );
  }

  Padding buildRowCheckBox(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
      child: Row(
        children: [
          buildCheckBox(context),
          SizedBox(width: context.dynamicWidht(0.02)),
          LocaleText(
            text: LocaleKeys.payment_payment_add_to_registered_cards,
            style: AppTextStyles.subTitleStyle,
          ),
        ],
      ),
    );
  }

  Column buildPayWithAnotherCard(BuildContext context) {
    return Column(
      children: [
        buildTextFormField(
            LocaleKeys.payment_payment_name_on_card.locale, nameController),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        buildTextFormField(
            LocaleKeys.payment_payment_card_number.locale, cardController),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildDropDown(context, dropdownMonthValue, months),
              buildDropDown(context, dropdownYearValue, years),
              buildCvvTextFormField(),
            ],
          ),
        ),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
      ],
    );
  }

  Container buildDropDown(
      BuildContext context, String dropdownValue, List<String> items) {
    return Container(
      height: context.dynamicHeight(0.06),
      width: context.dynamicWidht(0.22),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
        border: Border.all(
          color: AppColors.borderAndDividerColor,
          width: 2,
        ),
      ),
      child: DropdownButton<String>(
        underline: Text(""),
        value: dropdownValue == dropdownMonthValue
            ? dropdownMonthValue
            : dropdownYearValue,
        icon: Padding(
          padding: EdgeInsets.only(left: context.dynamicWidht(0.04)),
          child: const Icon(Icons.keyboard_arrow_down),
        ),
        iconSize: 15,
        style: AppTextStyles.bodyTextStyle,
        onChanged: (String? newValue) {
          setState(() {
            if (dropdownValue == dropdownMonthValue) {
              dropdownMonthValue = newValue!;
            } else {
              dropdownYearValue = newValue!;
            }
          });
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: AutoSizeText(
              value,
              style: AppTextStyles.bodyTextStyle,
              maxLines: 1,
            ),
          );
        }).toList(),
      ),
    );
  }

  Padding buildTextFormField(
      String labelText, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
      child: Container(
        color: Colors.white,
        child: TextFormField(
               inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
          ],
          cursorColor: AppColors.cursorColor,
          style:
              AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: AppTextStyles.bodyTextStyle,
            enabledBorder: buildOutlineInputBorder(),
            focusedBorder: buildOutlineInputBorder(),
            border: buildOutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.borderAndDividerColor, width: 2),
      borderRadius: BorderRadius.circular(4.0),
    );
  }

  Container buildCvvTextFormField() {
    return Container(
      height: context.dynamicHeight(0.06),
      width: context.dynamicWidht(0.33),
      color: Colors.white,
      child: TextFormField(
             inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
        ],
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.bodyTextStyle,
        controller: cvvController,
        decoration: InputDecoration(
          suffixIcon: Container(
            padding:
                EdgeInsets.symmetric(vertical: context.dynamicHeight(0.02)),
            child: SvgPicture.asset(
              ImageConstant.PAYMENT_CVV_ICON,
            ),
          ),
          hintText: "CVV/CV2 ",
          hintStyle: AppTextStyles.bodyTextStyle,
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

  buildCards() {
    List<Widget> cards = [];
    cards.add(buildCardListTile(
        cards, "İş Bankası Kartım", "492134******3434", cards.length));
    cards.add(buildCardListTile(
        cards, "Garanti Bankası Kartım", "492134******3434", cards.length));
    return cards;
  }

  ListTile buildCardListTile(
      List<Widget> cards, String text, String cardNumber, int index) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: text,
        style: AppTextStyles.subTitleStyle,
      ),
      subtitle: Text(
        cardNumber,
        style: AppTextStyles.myInformationBodyTextStyle,
      ),
      trailing: selectedIndex == cards.length
          ? SvgPicture.asset(ImageConstant.REGISTER_LOGIN_PASSWORD_TICK)
          : null,
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }

  Padding buildAnotherCardButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: CustomButton(
        width: double.infinity,
        title: payWithAnotherCard
            ? LocaleKeys.payment_payment_cancel
            : LocaleKeys.payment_payment_pay_another_card,
        color: Colors.transparent,
        borderColor: AppColors.greenColor,
        textColor: AppColors.greenColor,
        onPressed: () {
          setState(() {
            if (!payWithAnotherCard) {
              payWithAnotherCard = true;
            } else {
              payWithAnotherCard = false;
            }
          });
        },
      ),
    );
  }

  Container buildCheckBox(BuildContext context) {
    return Container(
      height: context.dynamicWidht(0.04),
      width: context.dynamicWidht(0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFD1D0D0),
        ),
      ),
      child: Theme(
        data: ThemeData(unselectedWidgetColor: Colors.transparent),
        child: Checkbox(
          checkColor: Colors.greenAccent,
          activeColor: Colors.transparent,
          value: checkboxAddCardValue,
          onChanged: (value) {
            setState(() {
              checkboxAddCardValue = value!;
            });
          },
        ),
      ),
    );
  }

  Padding buildBodyTitle(BuildContext context, String titleLeft) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
      ),
      child: LocaleText(
        text: titleLeft,
        style: AppTextStyles.bodyTitleStyle,
      ),
    );
  }
}

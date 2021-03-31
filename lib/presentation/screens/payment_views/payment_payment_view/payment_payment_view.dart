import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/presentation/screens/agreement_view/components/accept_agreement_text.dart';
import 'package:dongu_mobile/presentation/widgets/warning_container/warning_container.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/payment_total_price.dart';

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

  bool checkboxInfoValue = false;
  bool checkboxAgreementValue = false;
  bool checkboxAddCardValue = false;

  String selectedCashOrCredit = "cash";
  int selectedIndex = 0;
  bool payWithAnotherCard = false;

  TextEditingController cardController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        buildBottomCard(context),
      ],
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
        buildCashOrCreditListTile(context, LocaleKeys.payment_payment_cash, "cash"),
        buildCashOrCreditListTile(context, LocaleKeys.payment_payment_credit, "credit"),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        WarningContainer(text: "Ödeme şekliniz sipariş teslimatı\nesnasında kapıda değiştirilemez."),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        WarningContainer(text: "Ödemenizi size iletmiş olduğumuz\nsipariş numarasını restorana\ngöstererek yapınız."),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
      ],
    );
  }

  ListTile buildCashOrCreditListTile(BuildContext context, String text, String cashOrCredit) {
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
      trailing: selectedCashOrCredit == cashOrCredit ? SvgPicture.asset(ImageConstant.REGISTER_LOGIN_PASSWORD_TICK) : null,
      onTap: () {
        setState(() {
          selectedCashOrCredit = cashOrCredit;
        });
      },
    );
  }

  Column buildOnline(BuildContext context) {
    return Column(
      children: [
        buildRowTitleLeftRight(context, payWithAnotherCard ? LocaleKeys.payment_payment_pay_another_card : LocaleKeys.payment_payment_choose_card,
            LocaleKeys.payment_payment_edit),
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
              buildAnotherCardButton(context),
              SizedBox(
                height: context.dynamicHeight(0.17),
              ),
            ],
          ),
        ),
        Visibility(
          visible: payWithAnotherCard,
          child: buildPayWithAnotherCard(context),
        ),
      ],
    );
  }

  Column buildPayWithAnotherCard(BuildContext context) {
    return Column(
      children: [
        buildTextFormField(LocaleKeys.payment_payment_name_on_card, nameController),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        buildTextFormField(LocaleKeys.payment_payment_card_number, cardController),
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
        buildAddCardCheckBox(context, checkboxAddCardValue),
        SizedBox(
          height: context.dynamicHeight(0.1),
        ),
      ],
    );
  }

  Container buildBottomCard(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.dynamicHeight(0.29),
      padding: EdgeInsets.only(
          left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06), top: context.dynamicHeight(0.01), bottom: context.dynamicHeight(0.04)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LocaleText(text: LocaleKeys.payment_payment_order_amount, style: AppTextStyles.bodyTextStyle),
              PaymentTotalPrice(
                price: 70.50,
                withDecimal: true,
              ),
            ],
          ),
          Divider(
            height: context.dynamicHeight(0.01),
            thickness: 2,
            color: AppColors.borderAndDividerColor,
          ),
          Spacer(flex: 5),
          buildRowCheckBoxAgreement(context, "Ön Bilgilendirme Koşulları", "’nı okudum, onaylıyorum.", "info"),
          Spacer(flex: 4),
          buildRowCheckBoxAgreement(context, "Mesafeli Satış Sözleşmesi", "’nı okudum, onaylıyorum.", "agreement"),
          Spacer(flex: 9),
          buildRowTotalPayment(context),
        ],
      ),
    );
  }

  Row buildRowTotalPayment(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: context.dynamicHeight(0.052),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LocaleText(
                text: LocaleKeys.payment_payment_to_be_paid,
                style: AppTextStyles.myInformationBodyTextStyle,
                maxLines: 1,
              ),
              LocaleText(
                text: '70,50 TL',
                style: GoogleFonts.montserrat(
                  fontSize: 18.0,
                  color: AppColors.greenColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        CustomButton(
          width: context.dynamicWidht(0.5),
          title: LocaleKeys.payment_payment_pay,
          color: AppColors.greenColor,
          textColor: Colors.white,
          borderColor: AppColors.greenColor,
        ),
      ],
    );
  }

  Padding buildAddCardCheckBox(BuildContext context, bool checkValue) {
    return Padding(
      padding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
      child: Row(
        children: [
          buildCheckBox(context, "card"),
          SizedBox(width: context.dynamicWidht(0.02)),
          LocaleText(
            text: LocaleKeys.payment_payment_add_to_registered_cards,
            style: AppTextStyles.subTitleStyle,
          ),
        ],
      ),
    );
  }

  Container buildDropDown(BuildContext context, String dropdownValue, List<String> items) {
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
        value: dropdownValue == dropdownMonthValue ? dropdownMonthValue : dropdownYearValue,
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

  Padding buildTextFormField(String labelText, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
      child: Container(
        color: Colors.white,
        child: TextFormField(
          cursorColor: AppColors.cursorColor,
          style: AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.w600),
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: AppTextStyles.bodyTextStyle,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.borderAndDividerColor, width: 2),
              borderRadius: BorderRadius.circular(4.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.borderAndDividerColor, width: 2),
              borderRadius: BorderRadius.circular(4.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ),
    );
  }

  Container buildCvvTextFormField() {
    return Container(
      height: context.dynamicHeight(0.06),
      width: context.dynamicWidht(0.33),
      color: Colors.white,
      child: TextFormField(
        cursorColor: AppColors.cursorColor,
        style: AppTextStyles.bodyTextStyle,
        controller: cvvController,
        decoration: InputDecoration(
          suffixIcon: Container(
            padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.02)),
            child: SvgPicture.asset(
              ImageConstant.PAYMENT_CVV_ICON,
            ),
          ),
          hintText: "CVV/CV2 ",
          hintStyle: AppTextStyles.bodyTextStyle,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderAndDividerColor, width: 2),
            borderRadius: BorderRadius.circular(4.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderAndDividerColor, width: 2),
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
    cards.add(buildCardListTile(cards, "İş Bankası Kartım", "492134******3434", cards.length));
    cards.add(buildCardListTile(cards, "Garanti Bankası Kartım", "492134******3434", cards.length));
    return cards;
  }

  ListTile buildCardListTile(List<Widget> cards, String text, String cardNumber, int index) {
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
      trailing: selectedIndex == cards.length ? SvgPicture.asset(ImageConstant.REGISTER_LOGIN_PASSWORD_TICK) : null,
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }

  Row buildRowCheckBoxAgreement(BuildContext context, String underlinedText, String text, String checkValue) {
    return Row(
      children: [
        buildCheckBox(context, checkValue),
        Spacer(flex: 1),
        AcceptAgreementText(
          underlinedText: underlinedText,
          text: text,
          style: AppTextStyles.subTitleStyle,
        ),
        Spacer(flex: 5),
      ],
    );
  }

  Container buildCheckBox(BuildContext context, String checkValue) {
    return Container(
      height: context.dynamicWidht(0.04),
      width: context.dynamicWidht(0.04),
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
          value: checkValue == "info"
              ? checkboxInfoValue
              : checkValue == "agreement"
                  ? checkboxAgreementValue
                  : checkboxAddCardValue,
          onChanged: (value) {
            setState(() {
              if (checkValue == "info") {
                checkboxInfoValue = value!;
              } else if (checkValue == "agreement") {
                checkboxAgreementValue = value!;
              } else {
                checkboxAddCardValue = value!;
              }
            });
          },
        ),
      ),
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
        title: LocaleKeys.payment_payment_pay_another_card,
        color: Colors.transparent,
        borderColor: AppColors.greenColor,
        textColor: AppColors.greenColor,
        onPressed: () {
          setState(() {
            payWithAnotherCard = true;
          });
        },
      ),
    );
  }

  Padding buildRowTitleLeftRight(BuildContext context, String titleLeft, String titleRight) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LocaleText(
            text: titleLeft,
            style: AppTextStyles.bodyTitleStyle,
          ),
          GestureDetector(
            onTap: () {},
            child: LocaleText(
              text: titleRight,
              style: GoogleFonts.montserrat(
                fontSize: 12.0,
                color: AppColors.orangeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

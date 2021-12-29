import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_registered_card.dart';

import 'package:dongu_mobile/data/shared/shared_prefs.dart';

import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_card_cubit/iyzico_card_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  String? monthValue;
  String? yearValue;

  List<String> months = <String>[
    '  01',
    '  02',
    '  03',
    '  04',
    '  05',
    '  06',
    '  07',
    '  08',
    '  09',
    '  10',
    '  11',
    '  12'
  ];
  List<String> years = <String>[
    '  2021',
    '  2022',
    '  2023',
    '  2024',
    '  2025',
    '  2026',
    '  2027',
    '  2028',
    '  2029',
    '  2030'
  ];
  bool checkboxAddCardValue = false;
  bool threeDSecure = false;
  String selectedCashOrCredit = "cash";
  int selectedIndex = 0;
  bool payWithAnotherCard = false;
  String cardTokenGlobal = "";
  TextEditingController cardController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();

  @override
  void initState() {
    context.read<IyzicoCardCubit>().getCards();
    super.initState();
  }

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
        WarningContainer(text: LocaleKeys.payment_payment_warning_container),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        WarningContainer(text: LocaleKeys.payment_payment_warning_container),
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
          child: Builder(builder: (context) {
            final GenericState state = context.watch<IyzicoCardCubit>().state;

            if (state is GenericInitial) {
              return Container();
            } else if (state is GenericLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GenericCompleted) {
              List<CardDetail> cards = [];

              for (int i = 0; i < state.response.length; i++) {
                cards.add(state.response[i]);
              }

              return Column(
                children: [
                  buildCards(cards),
                  SizedBox(
                    height: context.dynamicHeight(0.02),
                  ),
                ],
              );
            } else {
              final error = state as GenericError;
              return Center(
                  child: Text("${error.message}\n${error.statusCode}"));
            }
          }),
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
                    buildTextFormField(
                      LocaleKeys.payment_payment_name_card.locale,
                      cardNameController,
                    ),
                    SizedBox(
                      height: context.dynamicHeight(0.02),
                    ),
                  ],
                ),
              ),
              buildRowCheckBox(
                  context,
                  LocaleKeys.payment_payment_add_to_registered_cards,
                  'register'),
              SizedBox(height: context.dynamicHeight(0.01)),
              buildRowCheckBox(
                context,
                "3D Secure kullanmak istiyorum",
                'threeD',
              ),
              SizedBox(height: context.dynamicHeight(0.02)),
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
                    LocaleText(
                      text: LocaleKeys.payment_payment_pay_with_another_card,
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

  Padding buildRowCheckBox(BuildContext context, String text, String value) {
    return Padding(
      padding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
      child: Row(
        children: [
          value == 'threeD'
              ? buildCheckBoxForThreeD(context)
              : buildCheckBoxForRegister(context),
          SizedBox(width: context.dynamicWidht(0.02)),
          LocaleText(
            text: text,
            style: AppTextStyles.subTitleStyle,
          ),
        ],
      ),
    );
  }

  Column buildPayWithAnotherCard(BuildContext context) {
    SharedPrefs.setCardHolderName(nameController.text.toString());
    SharedPrefs.setCardNumber(cardController.text.toString());
    SharedPrefs.setCardAlias(cardNameController.text.toString());
    print(SharedPrefs.getBoolForRegisteredCard);

    return Column(
      children: [
        buildTextFormField(
          LocaleKeys.payment_payment_name_on_card.locale,
          nameController,
        ),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        buildTextFormField(
          LocaleKeys.payment_payment_card_number.locale,
          cardController,
        ),
        SizedBox(
          height: context.dynamicHeight(0.02),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildMonthDropDown(context, months),
              buildYearDropDown(context, years),
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

  Container buildMonthDropDown(BuildContext context, List<String> items) {
    return Container(
      height: context.dynamicHeight(0.06),
      width: context.dynamicWidht(0.28),
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
        underline: SizedBox(),
        hint: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 13, 0),
          child: LocaleText(
            text: LocaleKeys.payment_payment_card_info_month,
          ),
        ),
        value: monthValue,
        onChanged: (value) {
          setState(() {
            this.monthValue = value;
            SharedPrefs.setExpireMonth(value.toString().substring(2, 4));
          });
        },
        items: months.map((String item) {
          return DropdownMenuItem(
            child: Text(item),
            value: item,
          );
        }).toList(),
      ),
    );
  }

  Container buildYearDropDown(BuildContext context, List<String> items) {
    return Container(
      height: context.dynamicHeight(0.06),
      width: context.dynamicWidht(0.26),
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
        underline: SizedBox(),
        hint: Padding(
          padding: const EdgeInsets.fromLTRB(19, 0, 15, 0),
          child: LocaleText(
            text: LocaleKeys.payment_payment_card_info_year,
          ),
        ),
        value: yearValue,
        onChanged: (value) {
          setState(() {
            this.yearValue = value;
            SharedPrefs.setExpireYear(value.toString().substring(4, 6));
          });
        },
        items: years.map((String item) {
          return DropdownMenuItem(
            child: Text(item),
            value: item,
          );
        }).toList(),
      ),
    );
  }

  Padding buildTextFormField(
    String labelText,
    TextEditingController controller,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
      child: Container(
        color: Colors.white,
        child: TextFormField(
          inputFormatters: [
            //  FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
            FilteringTextInputFormatter.singleLineFormatter,
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
    SharedPrefs.setCVC(cvvController.text.toString());

    return Container(
      height: context.dynamicHeight(0.06),
      width: context.dynamicWidht(0.33),
      color: Colors.white,
      child: TextFormField(
        inputFormatters: [
          //  FilteringTextInputFormatter.deny(RegExp('[a-zA-Z0-9]'))
          FilteringTextInputFormatter.singleLineFormatter,
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

  buildCards(List<CardDetail> cards) {
    SharedPrefs.setBoolForRegisteredCard(true);
    print(SharedPrefs.getBoolForRegisteredCard);

    return cards.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return buildCardListTile(
                cards,
                cards[index].cardAlias.toString(),
                "${cards[index].binNumber!.replaceRange(4, 6, "*")}****${cards[index].lastFourDigits!.replaceRange(0, 2, "*")}",
                index,
                cards[index].cardToken.toString(),
              );
            },
          )
        : Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                SvgPicture.asset(ImageConstant.SURPRISE_PACK_ALERT),
                SizedBox(
                  height: 20,
                ),
                LocaleText(
                  alignment: TextAlign.center,
                  text: "Kayıtlı kartınız bulunmamaktadır.",
                  style: AppTextStyles.myInformationBodyTextStyle,
                ),
              ],
            ),
          );
  }

  ListTile buildCardListTile(
    List<CardDetail> cards,
    String text,
    String cardNumber,
    int index,
    String cardToken,
  ) {
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
      trailing: selectedIndex == index
          ? SvgPicture.asset(ImageConstant.REGISTER_LOGIN_PASSWORD_TICK)
          : null,
      onTap: () {
        setState(() {
          selectedIndex = index;
          cardTokenGlobal = cardToken;
          SharedPrefs.setBoolForRegisteredCard(true);
          SharedPrefs.setCardToken(cardToken);
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
              SharedPrefs.setBoolForRegisteredCard(false);
            } else {
              payWithAnotherCard = false;
              SharedPrefs.setBoolForRegisteredCard(true);
            }
          });
        },
      ),
    );
  }

  Container buildCheckBoxForThreeD(
    BuildContext context,
  ) {
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
          value: threeDSecure,
          onChanged: (value) {
            setState(() {
              threeDSecure = value!;
              SharedPrefs.setThreeDBool(threeDSecure);
            });
          },
        ),
      ),
    );
  }

  Container buildCheckBoxForRegister(BuildContext context) {
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
              SharedPrefs.setCardRegisterBool(checkboxAddCardValue);
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

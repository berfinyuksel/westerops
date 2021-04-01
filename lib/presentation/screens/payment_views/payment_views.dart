import 'package:dongu_mobile/presentation/screens/agreement_view/components/accept_agreement_text.dart';
import 'package:dongu_mobile/presentation/screens/payment_views/payment_address_view/payment_address_view.dart';
import 'package:dongu_mobile/presentation/screens/payment_views/payment_delivery_view/payment_delivery_view.dart';
import 'package:dongu_mobile/presentation/screens/payment_views/payment_payment_view/components/payment_total_price.dart';
import 'package:dongu_mobile/presentation/screens/payment_views/payment_payment_view/payment_payment_view.dart';
import 'package:dongu_mobile/presentation/widgets/button/custom_button.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentViews extends StatefulWidget {
  @override
  _PaymentViewsState createState() => _PaymentViewsState();
}

class _PaymentViewsState extends State<PaymentViews> with TickerProviderStateMixin {
  TabController? tabController;
  bool isGetIt = true;
  bool checkboxValue = false;
  bool isOnline = true;
  bool checkboxInfoValue = false;
  bool checkboxAgreementValue = false;
  bool checkboxAddCardValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  Padding buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.dynamicHeight(0.02),
        bottom: tabController!.index == 2 ? 0 : context.dynamicHeight(0.04),
      ),
      child: Column(
        children: [
          buildTabsContainer(context),
          buildDeliveryType(context),
          buildTabBars(),
          Spacer(),
          Visibility(visible: tabController!.index != 2, child: buildButton(context)),
          Visibility(visible: tabController!.index == 2, child: buildBottomCard(context)),
        ],
      ),
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
              Expanded(
                child: LocaleText(
                  text: LocaleKeys.payment_payment_to_be_paid,
                  style: AppTextStyles.myInformationBodyTextStyle,
                  maxLines: 1,
                ),
              ),
              Expanded(
                child: LocaleText(
                  text: '70,50 TL',
                  style: GoogleFonts.montserrat(
                    fontSize: 18.0,
                    color: AppColors.greenColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        CustomButton(
          width: context.dynamicWidht(0.5),
          title: LocaleKeys.payment_payment_pay,
          color: checkboxAgreementValue && checkboxInfoValue ? AppColors.greenColor : AppColors.disabledButtonColor,
          textColor: Colors.white,
          borderColor: checkboxAgreementValue && checkboxInfoValue ? AppColors.greenColor : AppColors.disabledButtonColor,
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

  Padding buildTabsContainer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.dynamicWidht(0.06),
      ),
      child: Column(
        children: [
          Container(
            height: context.dynamicHeight(0.07),
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(18.0),
                bottom: Radius.circular(8.0),
              ),
              color: Colors.white,
            ),
            child: buildTabs(),
          ),
          Divider(
            height: 0,
            thickness: 2,
            color: AppColors.borderAndDividerColor,
          ),
        ],
      ),
    );
  }

  Container buildDeliveryType(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.dynamicWidht(0.06),
      ),
      alignment: Alignment.center,
      color: Colors.white,
      height: context.dynamicHeight(0.1),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildGetIt(context),
          buildPackageDelivery(context),
        ],
      ),
    );
  }

  GestureDetector buildPackageDelivery(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (tabController!.index == 2) {
            isOnline = false;
          } else {
            isGetIt = false;
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: context.dynamicHeight(0.052),
        width: context.dynamicWidht(0.4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            color: const Color(0xFFD1D0D0),
          ),
        ),
        child: tabController!.index == 2
            ? LocaleText(
                text: "Kapıda Ödeme", style: AppTextStyles.bodyTextStyle.copyWith(color: !isOnline ? AppColors.greenColor : AppColors.textColor))
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    ImageConstant.PACKAGE_DELIVERY_ICON,
                    color: !isGetIt ? AppColors.greenColor : AppColors.iconColor,
                  ),
                  LocaleText(
                      text: LocaleKeys.payment_package_delivery,
                      style: AppTextStyles.bodyTextStyle.copyWith(color: !isGetIt ? AppColors.greenColor : AppColors.textColor)),
                ],
              ),
      ),
    );
  }

  GestureDetector buildGetIt(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (tabController!.index == 2) {
            isOnline = true;
          } else {
            isGetIt = true;
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: context.dynamicHeight(0.052),
        width: context.dynamicWidht(0.43),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            color: const Color(0xFFD1D0D0),
          ),
        ),
        child: tabController!.index == 2
            ? LocaleText(
                text: "Online Ödeme", style: AppTextStyles.bodyTextStyle.copyWith(color: isOnline ? AppColors.greenColor : AppColors.textColor))
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    ImageConstant.PACKAGE_ICON,
                    color: isGetIt ? AppColors.greenColor : AppColors.iconColor,
                  ),
                  LocaleText(
                    text: LocaleKeys.payment_get_it,
                    style: AppTextStyles.bodyTextStyle.copyWith(color: isGetIt ? AppColors.greenColor : AppColors.textColor),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController!.addListener(() {
      setState(() {});
    });
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: SvgPicture.asset(ImageConstant.BACK_ICON),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: SvgPicture.asset(ImageConstant.COMMONS_APP_BAR_LOGO),
      centerTitle: true,
    );
  }

  buildTabs() {
    List<Widget> tabs = [
      LocaleText(
        text: LocaleKeys.payment_tab_1,
        style: GoogleFonts.montserrat(
          fontSize: 16.0,
          color: tabController!.index == 0 ? AppColors.orangeColor : AppColors.textColor,
          fontWeight: tabController!.index == 0 ? FontWeight.w600 : FontWeight.w300,
        ),
      ),
      LocaleText(
        text: LocaleKeys.payment_tab_2,
        style: GoogleFonts.montserrat(
          fontSize: 16.0,
          color: tabController!.index == 1 ? AppColors.orangeColor : AppColors.textColor,
          fontWeight: tabController!.index == 1 ? FontWeight.w600 : FontWeight.w300,
        ),
      ),
      LocaleText(
        text: LocaleKeys.payment_tab_3,
        style: GoogleFonts.montserrat(
          fontSize: 16.0,
          color: tabController!.index == 2 ? AppColors.orangeColor : AppColors.textColor,
          fontWeight: tabController!.index == 2 ? FontWeight.w600 : FontWeight.w300,
        ),
      )
    ];

    return TabBar(
      controller: tabController,
      tabs: tabs,
      indicatorColor: AppColors.orangeColor,
      indicatorSize: TabBarIndicatorSize.label,
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.payment_button_go_on,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }

  buildTabBars() {
    return AnimatedBuilder(
        animation: tabController!.animation as Listenable,
        builder: (ctx, child) {
          if (tabController!.index == 0) {
            return PaymentAddressView(
              isGetIt: isGetIt,
            );
          } else if (tabController!.index == 1) {
            return PaymentDeliveryView(
              isGetIt: isGetIt,
            );
          } else {
            return PaymentPaymentView(
              isOnline: isOnline,
            );
          }
        });
  }
}

import 'dart:developer';

import 'package:dongu_mobile/logic/cubits/iyzico_order_create_with_3d_cubit/iyzico_order_create_with_3d_cubit.dart';
import 'package:dongu_mobile/presentation/screens/payment_views/payment_payment_view/components/html_view.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../data/services/local_notifications/local_notifications_service/local_notifications_service.dart';
import '../../../data/shared/shared_prefs.dart';
import '../../../logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import '../../../logic/cubits/order_bar_cubit/order_bar_cubit.dart';
import '../../../logic/cubits/order_cubit/order_received_cubit.dart';
import '../../../logic/cubits/payment_cubit/payment_cubit.dart';
import '../../../logic/cubits/store_courier_hours_cubit/store_courier_hours_cubit.dart';
import '../../../logic/cubits/sum_price_order_cubit/sum_price_order_cubit.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';
import '../agreement_view/components/accept_agreement_text.dart';
import 'payment_address_view/payment_address_view.dart';
import 'payment_delivery_view/payment_delivery_view.dart';
import 'payment_payment_view/components/payment_total_price.dart';
import 'payment_payment_view/payment_payment_view.dart';

class PaymentViews extends StatefulWidget {
  @override
  _PaymentViewsState createState() => _PaymentViewsState();
}

class _PaymentViewsState extends State<PaymentViews>
    with TickerProviderStateMixin {
  TabController? tabController;
  bool checkboxValue = false;
  bool checkboxInfoValue = false;
  bool checkboxAgreementValue = false;
  List<String>? menuList = SharedPrefs.getMenuList;
  bool checkboxAddCardValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Builder(builder: (context) {
        final PaymentState state = context.watch<PaymentCubit>().state;
        return buildBody(context, state);
      }),
    );
  }

  Padding buildBody(BuildContext context, PaymentState state) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.dynamicHeight(0.02),
        bottom: tabController!.index == 2 ? 0 : context.dynamicHeight(0.04),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildTabsContainer(context),
          buildDeliveryType(context, state),
          buildTabBars(state),
          Spacer(),
          Visibility(
              visible: tabController!.index != 2, child: buildButton(context)),
          Visibility(
              visible: tabController!.index == 2,
              child: buildBottomCard(context)),
        ],
      ),
    );
  }

  Padding buildAddCardCheckBox(BuildContext context, bool checkValue) {
    return Padding(
      padding: EdgeInsets.only(left: context.dynamicWidht(0.06)),
      child: Row(
        children: [
          //buildCheckBox(context, "card", myState),
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

  Container buildDeliveryType(BuildContext context, PaymentState state) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.dynamicWidht(0.06),
      ),
      alignment: Alignment.center,
      color: Colors.white,
      height: context.dynamicHeight(0.1),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: tabController!.index == 2
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          buildGetIt(context, state),
          Spacer(),
          tabController!.index == 0 || tabController!.index == 1
              ? buildPackageDelivery(context, state)
              : SizedBox()
        ],
      ),
    );
  }

  GestureDetector buildPackageDelivery(
      BuildContext context, PaymentState state) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (tabController!.index == 2) {
            context.read<PaymentCubit>().setIsOnline(false);
          } else {
            context.read<PaymentCubit>().setIsGetIt(false);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.only(left: context.dynamicWidht(0.02)),
        alignment: Alignment.center,
        height: context.dynamicHeight(0.052),
        width: context.dynamicWidht(0.45),
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
                text: "Kapıda Ödeme",
                style: AppTextStyles.bodyTextStyle.copyWith(
                    color: !state.isOnline!
                        ? AppColors.greenColor
                        : AppColors.textColor))
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 2),
                  SvgPicture.asset(
                    ImageConstant.PACKAGE_DELIVERY_ICON,
                    color: !state.isGetIt!
                        ? AppColors.greenColor
                        : AppColors.iconColor,
                    height: 28,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 6),
                  Padding(
                    padding: EdgeInsets.only(right: context.dynamicWidht(0.03)),
                    child: LocaleText(
                        text: LocaleKeys.payment_package_delivery,
                        style: AppTextStyles.bodyTextStyle.copyWith(
                            color: !state.isGetIt!
                                ? AppColors.greenColor
                                : AppColors.textColor)),
                  ),
                ],
              ),
      ),
    );
  }

  GestureDetector buildGetIt(BuildContext context, PaymentState state) {
    return GestureDetector(
      onTap: () {
        print(state.isOnline);
        print(state.isGetIt);
        setState(() {
          if (tabController!.index == 2) {
            context.read<PaymentCubit>().setIsOnline(true);
          } else {
            context.read<PaymentCubit>().setIsGetIt(true);
          }
        });
      },
      child: Container(
        alignment: Alignment.center,
        height: context.dynamicHeight(0.052),
        width: context.dynamicWidht(tabController!.index == 2 ? 0.82 : 0.42),
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
                text: LocaleKeys.payment_payment_online_payment,
                style: AppTextStyles.bodyTextStyle.copyWith(
                    color: state.isOnline!
                        ? AppColors.greenColor
                        : AppColors.textColor))
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    ImageConstant.PACKAGE_ICON,
                    color: state.isGetIt!
                        ? AppColors.greenColor
                        : AppColors.iconColor,
                    height: 30,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: context.dynamicWidht(0.04)),
                    child: LocaleText(
                      text: LocaleKeys.payment_get_it,
                      style: AppTextStyles.bodyTextStyle.copyWith(
                          color: state.isGetIt!
                              ? AppColors.greenColor
                              : AppColors.textColor),
                    ),
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
          color: tabController!.index == 0
              ? AppColors.orangeColor
              : AppColors.textColor,
          fontWeight:
              tabController!.index == 0 ? FontWeight.w600 : FontWeight.w300,
        ),
      ),
      LocaleText(
        text: LocaleKeys.payment_tab_2,
        style: GoogleFonts.montserrat(
          fontSize: 16.0,
          color: tabController!.index == 1
              ? AppColors.orangeColor
              : AppColors.textColor,
          fontWeight:
              tabController!.index == 1 ? FontWeight.w600 : FontWeight.w300,
        ),
      ),
      LocaleText(
        text: LocaleKeys.payment_tab_3,
        style: GoogleFonts.montserrat(
          fontSize: 16.0,
          color: tabController!.index == 2
              ? AppColors.orangeColor
              : AppColors.textColor,
          fontWeight:
              tabController!.index == 2 ? FontWeight.w600 : FontWeight.w300,
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
      padding: EdgeInsets.symmetric(
        horizontal: context.dynamicWidht(0.06),
      ),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.payment_button_go_on,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {
          setState(() {
            if (tabController!.index == 0) {
              tabController!.index = 1;
            } else if (tabController!.index == 1) {
              tabController!.index = 2;
            }
          });
        },
      ),
    );
  }

  buildTabBars(PaymentState state) {
    return AnimatedBuilder(
        animation: tabController!.animation as Listenable,
        builder: (ctx, child) {
          if (tabController!.index == 0) {
            return PaymentAddressView(
              isGetIt: state.isGetIt,
            );
          } else if (tabController!.index == 1) {
            return PaymentDeliveryView(
              isGetIt: state.isGetIt,
            );
          } else {
            return PaymentPaymentView(
              isOnline: state.isOnline,
            );
          }
        });
  }

  GestureDetector buildBottomCard(BuildContext context) {
    return GestureDetector(
      onTap: () => showConfirmationBottomSheet(context),
      child: Container(
        width: double.infinity,
        height: context.dynamicHeight(0.17),
        padding: EdgeInsets.only(
            left: context.dynamicWidht(0.06),
            right: context.dynamicWidht(0.06),
            top: context.dynamicHeight(0.01),
            bottom: context.dynamicHeight(0.04)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(18.0),
          ),
          color: Colors.white,
        ),
        child: Builder(builder: (context) {
          final stateOfSumPrice = context.watch<SumPriceOrderCubit>().state;

          return Column(
            children: [
              Container(
                height: 3,
                width: context.dynamicWidht(0.15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1.5),
                  color: Color(0xFF707070),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LocaleText(
                      text: LocaleKeys.payment_payment_order_amount,
                      style: AppTextStyles.bodyTextStyle),
                  PaymentTotalPrice(
                    price: stateOfSumPrice.toDouble(),
                    withDecimal: true,
                  ),
                ],
              ),
              Divider(
                height: context.dynamicHeight(0.01),
                thickness: 2,
                color: AppColors.borderAndDividerColor,
              ),
              Spacer(),
              Row(
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
                            text:
                                '${stateOfSumPrice.toDouble().toStringAsFixed(2)} TL',
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
                  Spacer(),
                  CustomButton(
                    width: context.dynamicWidht(0.5),
                    title: LocaleKeys.payment_payment_pay,
                    color: checkboxAgreementValue && checkboxInfoValue
                        ? AppColors.greenColor
                        : AppColors.disabledButtonColor,
                    textColor: Colors.white,
                    borderColor: checkboxAgreementValue && checkboxInfoValue
                        ? AppColors.greenColor
                        : AppColors.disabledButtonColor,
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }

  Future<dynamic> showConfirmationBottomSheet(BuildContext context) {
    return showMaterialModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext builder) {
          return StatefulBuilder(builder: (context, StateSetter myState) {
            return Container(
              height: context.dynamicHeight(0.2),
              padding:
                  EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.06)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(18.0),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Container(
                    height: 3,
                    width: context.dynamicWidht(0.3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.5),
                      color: Color(0xFF707070),
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  buildRowCheckBoxAgreement(
                      context,
                      LocaleKeys
                          .payment_payment_checkbox_agreement_text1.locale,
                      LocaleKeys
                          .payment_payment_checkbox_agreement_text2.locale,
                      "info",
                      myState),
                  Spacer(
                    flex: 2,
                  ),
                  buildRowCheckBoxAgreement(
                      context,
                      LocaleKeys
                          .payment_payment_checkbox_agreement_text3.locale,
                      LocaleKeys
                          .payment_payment_checkbox_agreement_text4.locale,
                      "agreement",
                      myState),
                  Spacer(
                    flex: 4,
                  ),
                  buildRowTotalPayment(context),
                  Spacer(
                    flex: 4,
                  ),
                ],
              ),
            );
          });
        });
  }

  Row buildRowCheckBoxAgreement(BuildContext context, String underlinedText,
      String text, String checkValue, StateSetter myState) {
    return Row(
      children: [
        buildCheckBoxForAggreements(context, checkValue, myState),
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
                child: Builder(builder: (context) {
                  final stateOfSumPrice =
                      context.watch<SumPriceOrderCubit>().state;

                  return LocaleText(
                    text: '${stateOfSumPrice.toDouble().toStringAsFixed(2)} TL',
                    style: GoogleFonts.montserrat(
                      fontSize: 18.0,
                      color: AppColors.greenColor,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        Builder(builder: (context) {
          return CustomButton(
            width: context.dynamicWidht(0.5),
            title: LocaleKeys.payment_payment_pay,
            color: checkboxAgreementValue && checkboxInfoValue
                ? AppColors.greenColor
                : AppColors.disabledButtonColor,
            textColor: Colors.white,
            borderColor: checkboxAgreementValue && checkboxInfoValue
                ? AppColors.greenColor
                : AppColors.disabledButtonColor,
            onPressed: () {
              if (checkboxAgreementValue && checkboxInfoValue) {
                log("BoolForRegisteredCard");
                log(SharedPrefs.getBoolForRegisteredCard.toString());
                log("ThreeDBool");
                log(SharedPrefs.getThreeDBool.toString());
                if (SharedPrefs.getBoolForRegisteredCard) {
                  buildPaymentForRegisteredCard(context);
                } else {
                  if (SharedPrefs.getThreeDBool) {
                    // with threeD
                    buildWith3DPayment(context);
                  } else {
                    buildWithout3DPayment(context);
                  }
                }
              }
            },
          );
        }),
      ],
    );
  }

  void buildWithout3DPayment(BuildContext context) {
    context.read<OrderReceivedCubit>().createOrderWithout3D(
          deliveryType: SharedPrefs.getDeliveryType,
          addressId: SharedPrefs.getActiveAddressId,
          billingAddressId: SharedPrefs.getActiveAddressId,
          cardAlias: SharedPrefs.getCardAlias,
          cardHolderName: SharedPrefs.getCardHolderName,
          cardNumber: SharedPrefs.getCardNumber,
          expireMonth: SharedPrefs.getExpireMonth,
          registerCard: SharedPrefs.getCardRegisterBool ? 1 : 0,
          expireYear: SharedPrefs.getExpireYear,
          cvc: SharedPrefs.getCVC,
          ip: SharedPrefs.getIpV4,
        );
    context
        .read<StoreCourierCubit>()
        .updateCourierHours(SharedPrefs.getCourierHourId);
    menuList!.clear();
    SharedPrefs.setCounter(0);
    SharedPrefs.setMenuList([]);
    context.read<BasketCounterCubit>().setCounter(0);
    context.read<OrderBarCubit>().stateOfBar(true);
    SharedPrefs.setOrderBar(true);
    Navigator.pushReplacementNamed(
        context, RouteConstant.ORDER_RECEIVING_VIEW_WITHOUT3D);
  }

  void buildWith3DPayment(BuildContext context) {
    context.read<IyzicoOrderCreateWith3DCubit>().createOrderWith3D(
          deliveryType: SharedPrefs.getDeliveryType,
          addressId: SharedPrefs.getActiveAddressId,
          billingAddressId: SharedPrefs.getActiveAddressId,
          cardAlias: SharedPrefs.getCardAlias,
          cardHolderName: SharedPrefs.getCardHolderName,
          cardNumber: SharedPrefs.getCardNumber,
          expireMonth: SharedPrefs.getExpireMonth,
          registerCard: SharedPrefs.getCardRegisterBool ? 1 : 0,
          expireYear: SharedPrefs.getExpireYear,
          cvc: SharedPrefs.getCVC,
          ip: SharedPrefs.getIpV4,
        );
    context
        .read<StoreCourierCubit>()
        .updateCourierHours(SharedPrefs.getCourierHourId);
    menuList!.clear();
    SharedPrefs.setCounter(0);
    SharedPrefs.setMenuList([]);
    context.read<BasketCounterCubit>().setCounter(0);
    context.read<OrderBarCubit>().stateOfBar(true);
    SharedPrefs.setOrderBar(true);
    showDialog(
      context: context,
      builder: (_) => WebViewForThreeD(),
    );
  }

  void buildPaymentForRegisteredCard(BuildContext context) {
    //   NotificationService().gotOrder();

    context.read<OrderReceivedCubit>().createOrderWithRegisteredCard(
          deliveryType: SharedPrefs.getDeliveryType,
          addressId: SharedPrefs.getActiveAddressId,
          billingAddressId: SharedPrefs.getActiveAddressId,
          ip: SharedPrefs.getIpV4,
          cardToken: SharedPrefs.getCardToken,
        );
    context
        .read<StoreCourierCubit>()
        .updateCourierHours(SharedPrefs.getCourierHourId);
    context.read<OrderBarCubit>().stateOfBar(true);
    SharedPrefs.setOrderBar(true);
    menuList!.clear();
    SharedPrefs.setCounter(0);
    SharedPrefs.setMenuList([]);
    context.read<BasketCounterCubit>().setCounter(0);
    Navigator.pushReplacementNamed(
        context, RouteConstant.ORDER_RECEIVING_VIEW_REGISTERED_CARD);
  }

  Container buildCheckBoxForAggreements(
      BuildContext context, String checkValue, StateSetter myState) {
    return Container(
      height: context.dynamicWidht(0.05),
      width: context.dynamicWidht(0.05),
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
            myState(() {});
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
}

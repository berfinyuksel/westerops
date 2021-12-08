import 'package:date_time_format/date_time_format.dart';
import 'package:dongu_mobile/logic/cubits/order_bar_cubit/order_bar_cubit.dart';
import 'package:dongu_mobile/presentation/screens/past_order_detail_view/components/custom_alert_dialog_for_cancel_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/order_received.dart';
import '../../../data/model/search_store.dart';
import '../../../data/repositories/update_order_repository.dart';
import '../../../data/services/locator.dart';
import '../../../data/shared/shared_prefs.dart';
import '../../../logic/cubits/avg_review_cubit/avg_review_cubit.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../logic/cubits/search_store_cubit/search_store_cubit.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../../widgets/text/locale_text.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';
import '../surprise_pack_view/components/custom_alert_dialog.dart';
import 'components/address_and_date_list_tile.dart';
import 'components/past_order_detail_basket_list_tile.dart';
import 'components/past_order_detail_body_title.dart';
import 'components/past_order_detail_payment_list_tile.dart';
import 'components/past_order_detail_total_payment_list_tile.dart';
import 'components/thanks_for_evaluation_container.dart';

class PastOrderDetailView extends StatefulWidget {
  final OrderReceived? orderInfo;

  const PastOrderDetailView({Key? key, this.orderInfo}) : super(key: key);
  @override
  _PastOrderDetailViewState createState() => _PastOrderDetailViewState();
}

class _PastOrderDetailViewState extends State<PastOrderDetailView> {
  int starDegreeService = 3;
  int starDegreeQuality = 3;
  int starDegreeTaste = 3;
  bool editVisibility = false;
  String mealNames = '';
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.past_order_detail_title,
      body: buildBody(context),
    );
  }

  ListView buildBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
        top: context.dynamicHeight(0.02),
      ),
      children: [
        AddressAndDateListTile(
          orderInfo: widget.orderInfo,
          date:
              '${widget.orderInfo!.buyingTime!.format(EuropeanDateFormats.standard)}',
        ),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
        PastOrderDetailBodyTitle(
          title: LocaleKeys.past_order_detail_body_title_1,
        ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        buildRestaurantListTile(context),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
        buildRowTitleLeftRight(
            context,
            LocaleKeys.past_order_detail_body_title_2,
            LocaleKeys.past_order_detail_edit),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        buildStarListTile(
            context, LocaleKeys.past_order_detail_evaluate_1, "service"),
        buildStarListTile(
            context, LocaleKeys.past_order_detail_evaluate_2, "quality"),
        buildStarListTile(
            context, LocaleKeys.past_order_detail_evaluate_3, "taste"),
        Visibility(
            visible: editVisibility, child: ThanksForEvaluationContainer()),
        Visibility(
          visible: editVisibility,
          child: Column(
            children: [
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
              buildButtonSecond(context),
            ],
          ),
        ),
        Visibility(
          visible: !editVisibility,
          child: SizedBox(
            height: context.dynamicHeight(0.02),
          ),
        ),
        buildButtonFirst(context),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
        PastOrderDetailBodyTitle(
          title: LocaleKeys.past_order_detail_body_title_3,
        ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: widget.orderInfo!.boxes!.length,
            itemBuilder: (BuildContext context, index) {
              List<String> meals = [];
              if (widget.orderInfo!.boxes![index].meals!.isNotEmpty) {
                for (var i = 0;
                    i < widget.orderInfo!.boxes![index].meals!.length;
                    i++) {
                  meals.add(widget.orderInfo!.boxes![index].meals![i].name!);
                }
                mealNames = meals.join('\n');
              }
              return PastOrderDetailBasketListTile(
                title: widget.orderInfo!.boxes![index].textName ?? '',
                price:
                    (widget.orderInfo!.cost! / widget.orderInfo!.boxes!.length),
                withDecimal: false,
                subTitle: widget.orderInfo!.boxes![index].meals!.isEmpty
                    ? ""
                    : mealNames,
              );
            }),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
        PastOrderDetailBodyTitle(
          title: LocaleKeys.past_order_detail_body_title_4,
        ),
        SizedBox(
          height: context.dynamicHeight(0.01),
        ),
        PastOrderDetailPaymentListTile(
          title: LocaleKeys.past_order_detail_payment_1,
          price: widget.orderInfo!.cost!.toDouble(),
          lineTrough: false,
          withDecimal: false,
        ),
        PastOrderDetailTotalPaymentListTile(
          title: LocaleKeys.past_order_detail_payment_4,
          price: widget.orderInfo!.cost!.toDouble(),
          withDecimal: true,
        ),
        SizedBox(
          height: context.dynamicHeight(0.03),
        ),
        Visibility(
          child: Padding(
            padding: EdgeInsets.only(
                left: context.dynamicWidht(0.06),
                right: context.dynamicWidht(0.06)),
            child: Builder(builder: (context) {
              return CustomButton(
                  width: double.infinity,
                  title: LocaleKeys.past_order_detail_cancel_order,
                  color: Colors.transparent,
                  borderColor: AppColors.greenColor,
                  textColor: AppColors.greenColor,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => CustomAlertDialogForCancelOrder(
                          customTextController: textController,
                          textMessage: LocaleKeys
                              .past_order_detail_cancel_order_alert_dialog_text,
                          buttonOneTitle: LocaleKeys.payment_payment_cancel,
                          buttonTwoTittle: LocaleKeys.address_address_approval,
                          imagePath: ImageConstant.SURPRISE_PACK_ALERT,
                          onPressedOne: () {
                            Navigator.of(context).pop();
                          },
                          onPressedTwo: () async {
                            StatusCode statusCode =
                                await sl<UpdateOrderRepository>().cancelOrder(
                                    widget.orderInfo!.id!, textController.text);
                            switch (statusCode) {
                              case StatusCode.success:
                                context.read<OrderBarCubit>().stateOfBar(false);
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    context.dynamicWidht(0.04)),
                                            width: context.dynamicWidht(0.87),
                                            height: context.dynamicHeight(0.29),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                Spacer(
                                                  flex: 8,
                                                ),
                                                SvgPicture.asset(
                                                  ImageConstant.SURPRISE_PACK,
                                                  height: context
                                                      .dynamicHeight(0.134),
                                                ),
                                                SizedBox(height: 10),
                                                LocaleText(
                                                  text: LocaleKeys
                                                      .past_order_detail_cancelled_order_successfully,
                                                  style: AppTextStyles
                                                      .bodyBoldTextStyle,
                                                  alignment: TextAlign.center,
                                                ),
                                                Spacer(
                                                  flex: 35,
                                                ),
                                                CustomButton(
                                                  onPressed: () {
                                                    context
                                                        .read<OrderBarCubit>()
                                                        .stateOfBar(false);
                                                    Navigator.of(context).pop();
                                                  },
                                                  width: context
                                                      .dynamicWidht(0.35),
                                                  color: AppColors.greenColor,
                                                  textColor: Colors.white,
                                                  borderColor:
                                                      AppColors.greenColor,
                                                  title: LocaleKeys
                                                      .forgot_password_ok,
                                                ),
                                                Spacer(
                                                  flex: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                break;
                              case StatusCode.unauthecticated:
                                showDialog(
                                  context: context,
                                  builder: (_) => CustomAlertDialog(
                                      textMessage: LocaleKeys
                                          .past_order_detail_unautherized_move,
                                      buttonOneTitle:
                                          LocaleKeys.custom_drawer_login_button,
                                      buttonTwoTittle: LocaleKeys
                                          .custom_drawer_register_button,
                                      imagePath: ImageConstant.SURPRISE_PACK,
                                      onPressedOne: () {
                                        Navigator.of(context).pushNamed(
                                            RouteConstant.LOGIN_VIEW);
                                      },
                                      onPressedTwo: () {
                                        Navigator.of(context).pushNamed(
                                            RouteConstant.REGISTER_VIEW);
                                      }),
                                );
                                break;
                              default:
                                showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    context.dynamicWidht(0.04)),
                                            width: context.dynamicWidht(0.87),
                                            height: context.dynamicHeight(0.29),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                Spacer(
                                                  flex: 8,
                                                ),
                                                SvgPicture.asset(
                                                  ImageConstant
                                                      .SURPRISE_PACK_ALERT,
                                                  height: context
                                                      .dynamicHeight(0.134),
                                                ),
                                                SizedBox(height: 10),
                                                LocaleText(
                                                  text: LocaleKeys
                                                      .past_order_detail_cancel_order_error,
                                                  style: AppTextStyles
                                                      .bodyBoldTextStyle,
                                                  alignment: TextAlign.center,
                                                ),
                                                Spacer(
                                                  flex: 35,
                                                ),
                                                CustomButton(
                                                  onPressed: () {
                                                    context
                                                        .read<OrderBarCubit>()
                                                        .stateOfBar(false);
                                                    Navigator.of(context).pop();
                                                  },
                                                  width: context
                                                      .dynamicWidht(0.35),
                                                  color: AppColors.greenColor,
                                                  textColor: Colors.white,
                                                  borderColor:
                                                      AppColors.greenColor,
                                                  title: LocaleKeys
                                                      .forgot_password_ok,
                                                ),
                                                Spacer(
                                                  flex: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                            }
                          }),
                    );
                  });
            }),
          ),
        ),
      ],
    );
  }

  Padding buildButtonSecond(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.past_order_detail_button_2,
        color: Colors.transparent,
        borderColor: AppColors.greenColor,
        textColor: AppColors.greenColor,
        onPressed: () {
          setState(() {
            editVisibility = true;
          });
          Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
        },
      ),
    );
  }

  ListTile buildStarListTile(
      BuildContext context, String title, String whichStars) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildStar(whichStars, 1),
          Container(
            margin: EdgeInsets.only(left: context.dynamicWidht(0.02)),
            child: buildStar(whichStars, 2),
          ),
          Container(
            margin: EdgeInsets.only(left: context.dynamicWidht(0.02)),
            child: buildStar(whichStars, 3),
          ),
          Container(
            margin: EdgeInsets.only(left: context.dynamicWidht(0.02)),
            child: buildStar(whichStars, 4),
          ),
          Container(
            margin: EdgeInsets.only(left: context.dynamicWidht(0.02)),
            child: buildStar(whichStars, 5),
          ),
        ],
      ),
      tileColor: Colors.white,
      title: LocaleText(
          text: title, style: AppTextStyles.myInformationBodyTextStyle),
      onTap: () {},
    );
  }

  GestureDetector buildStar(String whichStars, int grade) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!editVisibility) {
            if (whichStars == "service") {
              starDegreeService = grade;
            } else if (whichStars == "quality") {
              starDegreeQuality = grade;
            } else {
              starDegreeTaste = grade;
            }
          }
        });
      },
      child: SvgPicture.asset(
        whichStars == "service"
            ? starDegreeService > grade - 1
                ? ImageConstant.PAST_ORDER_DETAIL_FILLED_STAR_ICON
                : ImageConstant.PAST_ORDER_DETAIL_STAR_ICON
            : whichStars == "quality"
                ? starDegreeQuality > grade - 1
                    ? ImageConstant.PAST_ORDER_DETAIL_FILLED_STAR_ICON
                    : ImageConstant.PAST_ORDER_DETAIL_STAR_ICON
                : starDegreeTaste > grade - 1
                    ? ImageConstant.PAST_ORDER_DETAIL_FILLED_STAR_ICON
                    : ImageConstant.PAST_ORDER_DETAIL_STAR_ICON,
      ),
    );
  }

  Builder buildRestaurantListTile(BuildContext context) {
    return Builder(builder: (context) {
      final GenericState stateOfSearchStore =
          context.watch<SearchStoreCubit>().state;

      if (stateOfSearchStore is GenericCompleted) {
        List<SearchStore> chosenRestaurat = [];
        if (widget.orderInfo!.boxes!.isNotEmpty) {
          for (var i = 0; i < stateOfSearchStore.response.length; i++) {
            if (stateOfSearchStore.response[i].id ==
                widget.orderInfo!.boxes![0].store!.id) {
              chosenRestaurat.add(stateOfSearchStore.response[i]);
            }
          }
        }

        return widget.orderInfo!.boxes!.isNotEmpty
            ? ListTile(
                contentPadding: EdgeInsets.only(
                  left: context.dynamicWidht(0.06),
                  right: context.dynamicWidht(0.06),
                ),
                trailing: SvgPicture.asset(
                  ImageConstant.COMMONS_FORWARD_ICON,
                ),
                tileColor: Colors.white,
                title: LocaleText(
                  text: widget.orderInfo!.boxes!.length != 0
                      ? widget.orderInfo!.boxes![0].store!.name
                      : '',
                  style: AppTextStyles.bodyTextStyle,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(
                    context,
                    RouteConstant.RESTAURANT_DETAIL,
                    arguments: ScreenArgumentsRestaurantDetail(
                      restaurant: chosenRestaurat[0],
                    ),
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
                      text: LocaleKeys.past_order_detail_no_restaurant_info,
                      style: AppTextStyles.myInformationBodyTextStyle,
                    ),
                  ],
                ),
              );
      } else if (stateOfSearchStore is GenericInitial) {
        return Container();
      } else if (stateOfSearchStore is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else {
        final error = stateOfSearchStore as GenericError;

        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Padding buildRowTitleLeftRight(
      BuildContext context, String titleLeft, String titleRight) {
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
          Visibility(
            visible: editVisibility,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  editVisibility = false;
                });
              },
              child: LocaleText(
                text: titleRight,
                style: GoogleFonts.montserrat(
                  fontSize: 12.0,
                  color: AppColors.orangeColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Visibility buildButtonFirst(BuildContext context) {
    return Visibility(
      visible: !editVisibility,
      child: Padding(
        padding: EdgeInsets.only(
            left: context.dynamicWidht(0.06),
            right: context.dynamicWidht(0.06)),
        child: CustomButton(
          width: double.infinity,
          title: LocaleKeys.past_order_detail_button_1,
          color: AppColors.greenColor,
          borderColor: AppColors.greenColor,
          textColor: Colors.white,
          onPressed: () {
            context.read<AvgReviewCubit>().postReview(
                  starDegreeTaste,
                  starDegreeService,
                  starDegreeQuality,
                  widget.orderInfo!.id!,
                  SharedPrefs.getUserId,
                  widget.orderInfo!.boxes![0].store!.id!,
                );
            setState(() {
              editVisibility = true;
            });
          },
        ),
      ),
    );
  }
}

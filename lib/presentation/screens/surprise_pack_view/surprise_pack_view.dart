import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/data/repositories/update_order_repository.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';
import 'components/custom_alert_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurprisePackView extends StatefulWidget {
  final String? payload;
  SurprisePackView({Key? key, this.payload});
  @override
  _SurprisePackViewState createState() => _SurprisePackViewState();
}

class _SurprisePackViewState extends State<SurprisePackView> {
  late Timer timer;
  int hour = 1;
  int minute = 51;
  int second = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final GenericState state = context.watch<OrderReceivedCubit>().state;

      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<OrderReceived> orderInfo = [];
        for (var i = 0; i < state.response.length; i++) {
          orderInfo.add(state.response[i]);
        }

        return Scaffold(
          appBar: buildAppBar(context),
          body: buildBody(context, orderInfo),
        );
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Column buildBody(BuildContext context, List<OrderReceived> orderInfo) {
    return Column(
      children: [
        Spacer(
          flex: 18,
        ),
        LocaleText(
          text: LocaleKeys.surprise_pack_surprise_pack_opened,
          style: AppTextStyles.appBarTitleStyle.copyWith(
              fontWeight: FontWeight.w400, color: AppColors.orangeColor),
          alignment: TextAlign.center,
        ),
        Spacer(
          flex: 2,
        ),
        buildOrderNumber(orderInfo),
        SvgPicture.asset(ImageConstant.SURPRISE_PACK,
            height: context.dynamicHeight(0.4)),
        buildCountDown(context),
        Spacer(
          flex: 5,
        ),
        // Container(child: Text("data"),),
        buildBottomCard(context, orderInfo),
      ],
    );
  }

  Container buildBottomCard(
      BuildContext context, List<OrderReceived> orderInfo) {
    return Container(
      width: double.infinity,
      height: context.dynamicHeight(0.26),
      padding: EdgeInsets.symmetric(
        horizontal: context.dynamicWidht(0.06),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Spacer(
            flex: 39,
          ),
          buildFirstRow(context, orderInfo),
          buildSecondRow(context, orderInfo),
          Spacer(
            flex: 58,
          ),
          buildButtonsRow(context, orderInfo),
          Spacer(
            flex: 40,
          ),
        ],
      ),
    );
  }

  Row buildButtonsRow(BuildContext context, List<OrderReceived> orderInfo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomButton(
          width: context.dynamicWidht(0.416),
          title: LocaleKeys.surprise_pack_button_reject,
          color: Colors.transparent,
          textColor: AppColors.redColor,
          borderColor: AppColors.redColor,
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => CustomAlertDialog(
                    onPressedOne: () {
                      Navigator.of(context).pop();
                    },
                    onPressedTwo: () {
                      sl<UpdateOrderRepository>()
                          .updateOrderStatus(orderInfo.last.id!, 5);
                      Navigator.of(context)
                          .pushNamed(RouteConstant.SURPRISE_PACK_CANCELED_VIEW);
                    },
                    imagePath: ImageConstant.SURPRISE_PACK_ALERT,
                    textMessage: LocaleKeys.surprise_pack_alert_text,
                    buttonOneTitle: LocaleKeys.surprise_pack_alert_button1,
                    buttonTwoTittle: LocaleKeys.surprise_pack_alert_button2));
          },
        ),
        CustomButton(
          width: context.dynamicWidht(0.416),
          title: LocaleKeys.surprise_pack_button_accept,
          color: AppColors.greenColor,
          textColor: Colors.white,
          borderColor: AppColors.greenColor,
          onPressed: () {
            sl<UpdateOrderRepository>()
                .updateOrderStatus(orderInfo.last.id!, 3);
            Navigator.of(context)
                .pushNamed(RouteConstant.PAST_ORDER_DETAIL_VIEW,
                    arguments: ScreenArgumentsRestaurantDetail(
                      orderInfo: orderInfo.last,
                    ));
          },
        ),
      ],
    );
  }

  Padding buildSecondRow(BuildContext context, List<OrderReceived> orderInfo) {
    List<String> meals = [];
    String mealNames = "";
    if (orderInfo.last.boxes!.last.meals!.isNotEmpty) {
      for (var i = 0; i < orderInfo.last.boxes!.last.meals!.length; i++) {
        meals.add(orderInfo.last.boxes!.last.meals![i].name!);
      }
      mealNames = meals.join('\n');
    }
    return Padding(
      padding: EdgeInsets.only(right: context.dynamicWidht(0.01)),
      child: Row(
        children: [
          Spacer(),
          AutoSizeText(
            orderInfo.last.boxes!.last.meals!.isEmpty ? "" : mealNames,
            style: AppTextStyles.subTitleStyle,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Padding buildFirstRow(BuildContext context, List<OrderReceived> orderInfo) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.05)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AutoSizeText(
            '${LocaleKeys.surprise_pack_surprise_pack.locale} 1',
            style: AppTextStyles.myInformationBodyTextStyle,
          ),
          SvgPicture.asset(ImageConstant.SURPRISE_PACK_FORWARD_ICON),
          AutoSizeText(
            orderInfo.last.boxes!.last.textName.toString(),
            style: AppTextStyles.myInformationBodyTextStyle,
          ),
        ],
      ),
    );
  }

  Container buildCountDown(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.dynamicHeight(0.1),
      color: Colors.white,
      child: Row(
        children: [
          Spacer(flex: 5),
          SvgPicture.asset(ImageConstant.ORDER_RECEIVED_CLOCK_ICON),
          Spacer(flex: 1),
          LocaleText(
              text: LocaleKeys.order_received_count_down,
              style: AppTextStyles.bodyTitleStyle),
          Spacer(flex: 1),
          Text(
              '0$hour:${minute < 10 ? "0$minute" : minute}:${second < 10 ? "0$second" : second}',
              style: AppTextStyles.appBarTitleStyle),
          Text(
            " kaldı.",
            style: AppTextStyles.bodyTitleStyle,
          ),
          Spacer(flex: 5),
        ],
      ),
    );
  }

  AutoSizeText buildOrderNumber(List<OrderReceived> orderInfo) {
    return AutoSizeText.rich(
      TextSpan(
        style: AppTextStyles.bodyTextStyle,
        children: [
          TextSpan(
            text: LocaleKeys.order_received_order_number.locale,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
            ),
          ),
          TextSpan(
            text: orderInfo.last.refCode.toString(),
            style: GoogleFonts.montserrat(
              color: AppColors.greenColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: SvgPicture.asset(ImageConstant.COMMONS_CLOSE_ICON),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: SvgPicture.asset(ImageConstant.COMMONS_APP_BAR_LOGO),
      centerTitle: true,
    );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (hour == 0 && minute == 0 && second == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            if (second != 0) {
              second--;
            } else {
              second = 59;
              if (minute != 0) {
                minute--;
              } else {
                minute = 59;
                hour--;
              }
            }
          });
        }
      },
    );
  }
}

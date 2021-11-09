import 'package:date_time_format/date_time_format.dart';

import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderStatusBar extends StatefulWidget {
  const OrderStatusBar({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderStatusBar> createState() => _OrderStatusBarState();
}

class _OrderStatusBarState extends State<OrderStatusBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteConstant.PAST_ORDER_VIEW);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        height: 93,
        color: AppColors.greenColor,
        child: Builder(builder: (context) {
          final state = context.watch<OrderReceivedCubit>().state;

          if (state is GenericInitial) {
            return Container();
          } else if (state is GenericLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GenericCompleted) {
            List<OrderReceived> orderInfo = [];
            for (var i = 0; i < state.response.length; i++) {
              orderInfo.add(state.response[i]);
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LocaleText(
                      text: 'Aktif Siparişin',
                      style: AppTextStyles.subTitleBoldStyle,
                    ),
                    LocaleText(
                      text:
                          '${orderInfo.last.address!.name} - ${orderInfo.last.buyingTime!.format(EuropeanDateFormats.standard)}',
                      style: AppTextStyles.subTitleBoldStyle,
                    ),
                    LocaleText(
                      text: orderInfo.last.boxes![0].store!.name,
                      style: AppTextStyles.bodyBoldTextStyle
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
                buildCountDown(context),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: context.dynamicWidht(0.01)),
                  width: 69,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: AppColors.scaffoldBackgroundColor,
                  ),
                  child: Text(
                    '${orderInfo.last.cost} TL',
                    style: AppTextStyles.bodyBoldTextStyle
                        .copyWith(color: AppColors.greenColor),
                  ),
                ),
                SvgPicture.asset(
                  ImageConstant.COMMONS_FORWARD_ICON,
                  fit: BoxFit.fitWidth,
                  color: Colors.white,
                ),
              ],
            );
          } else {
            final error = state as GenericError;
            return Center(child: Text("${error.message}\n${error.statusCode}"));
          }
        }),
      ),
    );
  }

  Text buildCountDown(BuildContext context) {
    List<int> timeNowHourCompo = buildTimeNow();
    String cachedTimeForDelivery = SharedPrefs.getCountDownString;
    List<String> cachedTimeForDeliveryStringList =
        cachedTimeForDelivery.split(":").toList();
    cachedTimeForDeliveryStringList.add("00");
    print(cachedTimeForDeliveryStringList);
    List<int> cachedTimeForDeliveryIntList = [];
    for (var i = 0; i < cachedTimeForDeliveryStringList.length; i++) {
      cachedTimeForDeliveryIntList
          .add(int.parse(cachedTimeForDeliveryStringList[i]));
    }

    int hour = (cachedTimeForDeliveryIntList[0] - timeNowHourCompo[0]);
    int minute = (cachedTimeForDeliveryIntList[1] - timeNowHourCompo[1]);
    int second = (cachedTimeForDeliveryIntList[2] - timeNowHourCompo[2]);
    int duration = ((hour * 60 * 60) + (minute * 60) + (second));
    int mathedHour = (duration ~/ (60 * 60));
    int mathedMinute = (duration - (mathedHour * 60 * 60)) ~/ 60;

    int mathedSeconds =
        (duration - (mathedMinute * 60) - (mathedHour * 60 * 60));
    if (duration == 0) {
      SharedPrefs.setOrderBar(false);
    }
    String countDown =
        '${mathedHour < 10 ? "0$mathedHour" : "$mathedHour"}:${mathedMinute < 10 ? "0$mathedMinute" : "$mathedMinute"}:${mathedSeconds < 10 ? "0$mathedSeconds" : "$mathedSeconds"}';
    return Text(
      countDown,
      style: AppTextStyles.subTitleBoldStyle,
    );
  }

  List<int> buildTimeNow() {
    String timeNow = DateTime.now().toIso8601String();
    List<String> timeNowList = timeNow.split("T").toList();
    List<String> timeNowHourList = timeNowList[1].split(".").toList();
    List<String> timeNowComponentsList = timeNowHourList[0].split(":").toList();
    List<int> timeNowHourComponentList = [];

    timeNowComponentsList.forEach((e) {
      timeNowHourComponentList.add(int.parse(e));
    });
    return timeNowHourComponentList;
  }
}

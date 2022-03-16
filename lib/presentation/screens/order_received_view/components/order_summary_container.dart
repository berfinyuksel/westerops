import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/order_received.dart';
import '../../../../data/shared/shared_prefs.dart';
import '../../../../logic/cubits/payment_cubit/payment_cubit.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/extensions/string_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';

class OrderSummaryContainer extends StatelessWidget {
  final OrderReceived? orderInfo;
  const OrderSummaryContainer({Key? key, this.orderInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final PaymentState state = context.watch<PaymentCubit>().state;

      return Container(
        padding: EdgeInsets.only(left: context.dynamicWidht(0.07)),
        width: double.infinity,
        height: context.dynamicHeight(0.21),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(flex: 5),
            Text(
              buildTimeString(orderInfo!.buyingTime!.toLocal()),
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            Spacer(flex: 2),
            Text(
              "${orderInfo!.deliveryType == '1' ? SharedPrefs.getTimeIntervalForGetIt : SharedPrefs.getCourierHourText}${state.isGetIt! ? LocaleKeys.order_received_take_from_restaurant.locale : LocaleKeys.payment_description_text.locale}",
              style: AppTextStyles.bodyTextStyle,
            ),
            Spacer(flex: 2),
            Text(
              "${SharedPrefs.getDeliveryType == 1 ? LocaleKeys.order_received_get_it_package.locale : LocaleKeys.order_received_courier_package.locale} - ${state.isOnline! ? LocaleKeys.filters_payment_method_item1.locale : LocaleKeys.filters_payment_method_item2.locale}",
              style: AppTextStyles.bodyTextStyle,
            ),
            Spacer(flex: 5),
            Text(
              "${LocaleKeys.order_received_amount_in_cart.locale}${orderInfo!.boxes!.length}",
              style: AppTextStyles.bodyTextStyle,
            ),
            Spacer(flex: 3),
            Text(
              "${LocaleKeys.order_received_total_amount.locale} ${orderInfo!.cost.toString()} TL",
              style: AppTextStyles.myInformationBodyTextStyle,
            ),
            Spacer(flex: 5),
          ],
        ),
      );
    });
  }

  String buildTimeString(DateTime orderTime) {
    int month = orderTime.month;
    int day = orderTime.day;
    int year = orderTime.year;
    int hour = orderTime.hour;
    int minutes = orderTime.minute;
    String orderMonth = "";
    switch (month) {
      case 1:
        orderMonth = LocaleKeys.months_jan.locale;
        break;
      case 2:
        orderMonth = LocaleKeys.months_feb.locale;
        break;
      case 3:
        orderMonth = LocaleKeys.months_mar.locale;
        break;
      case 4:
        orderMonth = LocaleKeys.months_apr.locale;
        break;
      case 5:
        orderMonth = LocaleKeys.months_may.locale;
        break;
      case 6:
        orderMonth = LocaleKeys.months_june.locale;
        break;
      case 7:
        orderMonth = LocaleKeys.months_july.locale;
        break;
      case 8:
        orderMonth = LocaleKeys.months_aug.locale;
        break;
      case 9:
        orderMonth = LocaleKeys.months_sept.locale;
        break;
      case 10:
        orderMonth = LocaleKeys.months_oct.locale;
        break;
      case 11:
        orderMonth = LocaleKeys.months_nov.locale;
        break;
      case 12:
        orderMonth = LocaleKeys.months_dec.locale;
        break;
      default:
        break;
    }

    String orderTimeBuilded = '$day $orderMonth $year - $hour:$minutes';

    return orderTimeBuilded;
  }
}

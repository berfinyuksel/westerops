import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';
import 'package:dongu_mobile/presentation/screens/past_order_view/components/past_order_list_tile.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:dongu_mobile/utils/extensions/string_extension.dart';
import 'package:dongu_mobile/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';

class ListViewForOrders extends StatelessWidget {
  const ListViewForOrders({
    Key? key,
    required this.orderInfo,
  }) : super(key: key);

  final List<IyzcoOrderCreate> orderInfo;
  @override
  Widget build(BuildContext context) {
    var orderInfoReversed = List.from(orderInfo.reversed);
    return ListView.builder(
        itemCount: orderInfoReversed.length,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(RouteConstant.PAST_ORDER_DETAIL_VIEW,
                      arguments: ScreenArgumentsRestaurantDetail(
                        orderInfo: orderInfoReversed[index],
                      ));
            },
            child: PastOrderListTile(
              statusSituationForCancel: orderInfo[index].status == '5' ||
                      orderInfoReversed[index].status == '4' ||
                      orderInfoReversed[index].status == '0'
                  ? true
                  : false,
              title: "${orderInfoReversed[index].address!.name} - " +
                  buildTimeString(orderInfoReversed[index].buyingTime!),
              subtitle: orderInfoReversed[index].boxes!.length != 0
                  ? orderInfoReversed[index].boxes![0].store!.name
                  : '',
              price: "${orderInfoReversed[index].cost}",
            ),
          );
        });
  }

  String buildTimeString(DateTime orderTime) {
    int month = orderTime.month;
    int day = orderTime.day;
    int year = orderTime.year;
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

    String orderTimeBuilded = '$day $orderMonth $year';

    return orderTimeBuilded;
  }
}

import 'package:flutter/material.dart';

import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import 'components/past_order_list_tile.dart';

class PastOrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.past_order_title,
      body: ListView(
        padding: EdgeInsets.only(
          top: context.dynamicHeight(0.02),
        ),
        children: [
          PastOrderListTile(
            title: "Ev - 27 Şubat 2021  20:08",
            subtitle: "Canım Büfe",
            price: "35",
            onTap: () {
              Navigator.pushNamed(context, RouteConstant.PAST_ORDER_DETAIL_VIEW);
            },
          ),
          PastOrderListTile(
            title: "Ev - 02 Ocak 2021  17:32",
            subtitle: "Cafe On Numara",
            price: "15",
          ),
          PastOrderListTile(
            title: "İş Yerim - 03 Aralık 2020  19:08",
            subtitle: "Babacan Cafe",
            price: "45",
          ),
          PastOrderListTile(
            title: "Ev - 29 Kasım 2020  13:32",
            subtitle: "Renkli Cafe",
            price: "30",
          ),
        ],
      ),
    );
  }
}

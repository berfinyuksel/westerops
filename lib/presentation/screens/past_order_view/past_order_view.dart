import 'package:dongu_mobile/presentation/screens/past_order_view/components/past_order_list_tile.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';
import 'package:dongu_mobile/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class PastOrderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Geçmiş Siparişlerim",
      body: ListView(
        padding: EdgeInsets.only(
          top: context.dynamicHeight(0.02),
        ),
        children: [
          PastOrderListTile(
            title: "Ev - 27 Şubat 2021  20:08",
            subtitle: "Canım Büfe",
            price: "35",
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

import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/order_received.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../logic/cubits/order_cubit/order_received_cubit.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/locale_keys.g.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import '../restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'components/past_order_list_tile.dart';

class PastOrderView extends StatefulWidget {
  @override
  State<PastOrderView> createState() => _PastOrderViewState();
}

class _PastOrderViewState extends State<PastOrderView> {
  @override
  void initState() {
    super.initState();
    context.read<OrderReceivedCubit>().getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: LocaleKeys.past_order_title,
        body: Builder(builder: (context) {
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
            orderInfo.reversed;
            print(orderInfo.length);
            return ListView.builder(
                reverse: true,
                itemCount: orderInfo.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteConstant.PAST_ORDER_DETAIL_VIEW,
                              arguments: ScreenArgumentsRestaurantDetail(
                                orderInfo: orderInfo[index],
                              ));
                    },
                    child: PastOrderListTile(
                      statusSituationForCancel:
                          orderInfo[index].status == '5' ||
                                  orderInfo[index].status == '4' ||
                                  orderInfo[index].status == '0'
                              ? true
                              : false,
                      title:
                          "${orderInfo[index].address!.name} - ${orderInfo[index].buyingTime!.format(EuropeanDateFormats.standard)}",
                      subtitle: orderInfo[index].boxes!.length != 0
                          ? orderInfo[index].boxes![0].store!.name
                          : '',
                      price: "${orderInfo[index].cost}",
                    ),
                  );
                });
          } else {
            final error = state as GenericError;
            return Center(child: Text("${error.message}\n${error.statusCode}"));
          }
        }));
  }
}
/* ListView(
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
    */
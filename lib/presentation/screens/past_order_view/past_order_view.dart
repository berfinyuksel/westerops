import 'package:date_time_format/date_time_format.dart';
import 'package:dongu_mobile/data/model/order_received.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/screen_arguments/screen_arguments.dart';
import 'package:dongu_mobile/presentation/screens/surprise_pack_view/components/custom_alert_dialog.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/theme/app_colors/app_colors.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
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
import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/past_order_detail_cubit.dart';
import 'package:dongu_mobile/presentation/screens/past_order_view/components/listview_for_orders.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../utils/locale_keys.g.dart';
import '../../widgets/scaffold/custom_scaffold.dart';

class PastOrderView extends StatefulWidget {
  @override
  State<PastOrderView> createState() => _PastOrderViewState();
}

class _PastOrderViewState extends State<PastOrderView> {
  @override
  void initState() {
    super.initState();
    context.read<PastOrderDetailCubit>().getPastOrder();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        title: LocaleKeys.past_order_title,
        body: Builder(builder: (context) {
          final GenericState state =
              context.watch<PastOrderDetailCubit>().state;
          if (state is GenericInitial) {
            return Container();
          } else if (state is GenericLoading) {
            return Center(child: CustomCircularProgressIndicator());
          } else if (state is GenericCompleted) {
            List<IyzcoOrderCreate> orderInfo = [];
            for (var i = 0; i < state.response.length; i++) {
              orderInfo.add(state.response[i]);
            }
            orderInfo.sort((a, b) => a.buyingTime!.compareTo(b.buyingTime!));
            return ListViewForOrders(orderInfo: orderInfo);
          } else {
            final error = state as GenericError;
            return Center(child: Text("${error.message}\n${error.statusCode}"));
          }
        }));
  }
}

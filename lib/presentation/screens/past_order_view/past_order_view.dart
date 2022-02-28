import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';
import 'package:dongu_mobile/logic/cubits/order_cubit/order_received_cubit.dart';
import 'package:dongu_mobile/presentation/screens/past_order_view/components/listview_for_orders.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:dongu_mobile/utils/theme/app_text_styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    context.read<OrderReceivedCubit>().getPastOrder();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<OrderReceivedCubit>().getPastOrder();
    return CustomScaffold(
        title: LocaleKeys.past_order_title,
        body: Builder(builder: (context) {
          final GenericState state = context.watch<OrderReceivedCubit>().state;
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
            return orderInfo.isNotEmpty
                ? ListViewForOrders(orderInfo: orderInfo)
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        SvgPicture.asset(ImageConstant.SURPRISE_PACK_ALERT),
                        SizedBox(
                          height: 20.h,
                        ),
                        LocaleText(
                          alignment: TextAlign.center,
                          text: "Henüz siparişiniz bulunmamaktadır.",
                          style: AppTextStyles.myInformationBodyTextStyle,
                        ),
                      ],
                    ),
                  );
          } else {
            final error = state as GenericError;
            return Center(child: Text("${error.message}\n${error.statusCode}"));
          }
        }));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../logic/cubits/generic_state/generic_state.dart';
import '../../../logic/cubits/order_cubit/order_cubit.dart';
import '../../../utils/constants/image_constant.dart';
import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/text/locale_text.dart';
import '../past_order_detail_view/components/past_order_detail_basket_list_tile.dart';
import '../past_order_detail_view/components/past_order_detail_body_title.dart';
import '../past_order_detail_view/components/past_order_detail_payment_list_tile.dart';
import '../past_order_detail_view/components/past_order_detail_total_payment_list_tile.dart';
import 'empty_cart_view.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().getBasket();
  }

  @override
  Widget build(BuildContext context) {
    return buildBuilder();
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<OrderCubit>().state;
      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        if (state.response.length == 0) {
          return EmptyCartView();
        } else {
          return Center(child: buildBody(context, state));
        }
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Column buildBody(BuildContext context, GenericCompleted state) {
    return Column(
      children: [
        Container(
          height: context.dynamicHeight(0.7),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(
              top: context.dynamicHeight(0.02),
            ),
            children: [
              PastOrderDetailBodyTitle(
                title: LocaleKeys.past_order_detail_body_title_1,
              ),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
              buildRestaurantListTile(context),
              SizedBox(
                height: context.dynamicHeight(0.04),
              ),
              PastOrderDetailBodyTitle(
                title: LocaleKeys.past_order_detail_body_title_3,
              ),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.response.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      key: UniqueKey(),
                      background: Container(
                        color: AppColors.redColor,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: context.dynamicWidht(0.06)),
                        child: LocaleText(
                          text: LocaleKeys.my_notifications_delete_text_text,
                          style: AppTextStyles.bodyTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          alignment: TextAlign.end,
                        ),
                      ),
                      onDismissed: (DismissDirection direction) {
                        context.read<OrderCubit>().deleteBasket(state.response[index].id);
                      },
                      child: PastOrderDetailBasketListTile(
                        title: state.response[index].name,
                        price: 35,
                        withDecimal: false,
                        subTitle: "",
                      ),
                    );
                  }),
              SizedBox(
                height: context.dynamicHeight(0.04),
              ),
              PastOrderDetailBodyTitle(
                title: LocaleKeys.past_order_detail_body_title_4,
              ),
              SizedBox(
                height: context.dynamicHeight(0.01),
              ),
              PastOrderDetailPaymentListTile(
                title: LocaleKeys.past_order_detail_payment_1,
                price: 70,
                lineTrough: false,
                withDecimal: false,
              ),
              PastOrderDetailPaymentListTile(
                title: LocaleKeys.past_order_detail_payment_2,
                price: 4.50, 
                lineTrough: true,
                withDecimal: true,
              ),
              PastOrderDetailPaymentListTile(
                title: "${LocaleKeys.past_order_detail_payment_3.locale} (2)*",
                price: 0.50,
                lineTrough: false,
                withDecimal: true,
              ),
              PastOrderDetailTotalPaymentListTile(
                title: LocaleKeys.past_order_detail_payment_4,
                price: 70.50,
                withDecimal: true,
              ),
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
            ],
          ),
        ),
        Spacer(),
        buildButton(context),
      ],
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
        bottom: context.dynamicHeight(0.03),
      ),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.cart_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, RouteConstant.PAYMENTS_VIEW);
        },
      ),
    );
  }

  ListTile buildRestaurantListTile(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: SvgPicture.asset(
        ImageConstant.COMMONS_FORWARD_ICON,
      ),
      tileColor: Colors.white,
      title: LocaleText(
        text: "Canım Büfe",
        style: AppTextStyles.bodyTextStyle,
      ),
      onTap: () {},
    );
  }
}

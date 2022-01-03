import 'package:dongu_mobile/data/model/iyzico_card_model/iyzico_order_model.dart';

import '../../restaurant_details_views/screen_arguments/screen_arguments.dart';
import '../../../../utils/constants/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../my_favorites_view/components/address_text.dart';

class AddressAndDateListTile extends StatefulWidget {
  final String? date;
  final IyzcoOrderCreate? orderInfo;
  final int? orderStatus;
  const AddressAndDateListTile({
    Key? key,
    this.date,
    this.orderInfo,
    required this.orderStatus,
  }) : super(key: key);

  @override
  State<AddressAndDateListTile> createState() => _AddressAndDateListTileState();
}

class _AddressAndDateListTileState extends State<AddressAndDateListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: context.dynamicHeight(0.12),
      child: ListTile(
        contentPadding: EdgeInsets.only(
          left: context.dynamicWidht(0.06),
        ),
        trailing: Visibility(
          visible: widget.orderStatus == 2 ||
              widget.orderStatus == 9 ||
              widget.orderStatus == 1,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(RouteConstant.SWIPE_VIEW,
                  arguments: ScreenArgumentsRestaurantDetail(
                    orderInfo: widget.orderInfo,
                  ));
            },
            child: SvgPicture.asset(ImageConstant.PAST_ORDER_DETAIL_ICON_ARROW,
                fit: BoxFit.fitWidth),
          ),
        ),
        tileColor: Colors.white,
        title: AddressText(),
        subtitle: Text(
          widget.date!,
          style: AppTextStyles.subTitleStyle,
        ),
      ),
    );
  }
}

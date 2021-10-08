import 'package:dongu_mobile/utils/constants/route_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../my_favorites_view/components/address_text.dart';

class AddressAndDateListTile extends StatelessWidget {
  final String? date;
  const AddressAndDateListTile({
    Key? key,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: context.dynamicWidht(0.06),
        right: context.dynamicWidht(0.06),
      ),
      trailing: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RouteConstant.SWIPE_VIEW);
        },
        child: SvgPicture.asset(
          ImageConstant.PAST_ORDER_DETAIL_ICON,
          color: Colors.red,
          cacheColorFilter: false,
        ),
      ),
      tileColor: Colors.white,
      title: AddressText(),
      subtitle: Text(
        date!,
        style: AppTextStyles.subTitleStyle,
      ),
      onTap: () {},
    );
  }
}

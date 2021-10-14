import 'package:flutter/material.dart';

import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import 'components/address_view_title.dart';
import 'components/adress_list_tile.dart';
import '../../../utils/extensions/string_extension.dart';

class AddressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: LocaleKeys.address_title,
      body: Padding(
        padding: EdgeInsets.only(
          top: context.dynamicHeight(0.02),
          bottom: context.dynamicHeight(0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AddressBodyTitle(),
            buildList(context),
            Spacer(),
            buildButton(context),
          ],
        ),
      ),
    );
  }

  Container buildList(BuildContext context) {
    return Container(
      height: context.dynamicHeight(0.6),
      padding: EdgeInsets.only(
        top: context.dynamicHeight(0.01),
      ),
      child: ListView(
        children: [
          AddressListTile(
            title: LocaleKeys.address_text_1,
            subtitleBold: LocaleKeys.address_text_3.locale,
            subtitle: LocaleKeys.address_text_4.locale,
          ),
          AddressListTile(
            title: LocaleKeys.address_text_2,
            subtitleBold: LocaleKeys.address_text_3.locale,
            subtitle: LocaleKeys.address_text_4.locale,
          ),
        ],
      ),
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
      child: CustomButton(
        width: double.infinity,
        title: LocaleKeys.address_button,
        color: AppColors.greenColor,
        borderColor: AppColors.greenColor,
        textColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, RouteConstant.ADDRESS_FROM_MAP_VIEW);
        },
      ),
    );
  }
}

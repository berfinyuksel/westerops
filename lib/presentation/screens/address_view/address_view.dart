import 'package:flutter/material.dart';

import '../../../utils/constants/route_constant.dart';
import '../../../utils/extensions/context_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/scaffold/custom_scaffold.dart';
import 'components/address_view_title.dart';
import 'components/adress_list_tile.dart';

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
            title: "Ev",
            subtitleBold: "Beşiktaş (Kuruçeşme, Muallim Cad.)",
            subtitle: "\njonh.doe@mail.com\nLorem Ipsum Dolor sit amet No:5 D:5\n+90 555 555 55 55\nSüpermarketin üstü\n",
          ),
          AddressListTile(
            title: "İş yerim",
            subtitleBold: "Beşiktaş (Kuruçeşme, Muallim Cad.)",
            subtitle: "\njonh.doe@mail.com\nLorem Ipsum Dolor sit amet No:5 D:5\n+90 555 555 55 55\nSüpermarketin üstü\n",
          ),
        ],
      ),
    );
  }

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: context.dynamicWidht(0.06), right: context.dynamicWidht(0.06)),
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

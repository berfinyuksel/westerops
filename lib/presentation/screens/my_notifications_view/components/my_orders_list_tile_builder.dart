import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class MyOrdersListTileBuilder extends StatefulWidget {
  MyOrdersListTileBuilder({Key? key}) : super(key: key);

  @override
  _MyOrdersListTileBuilderState createState() => _MyOrdersListTileBuilderState();
}

class _MyOrdersListTileBuilderState extends State<MyOrdersListTileBuilder> {
  var value = <String>[
    "",
    "",
    "",
    "",
  ];
  @override
  Widget build(BuildContext context) {
    return listViewBuilder(value);
  }

  ListView listViewBuilder(
    List<String> value,
  ) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: value.length,
        itemBuilder: (context, index) {
          return Container(
            height: context.dynamicHeight(0.097),
            padding: EdgeInsets.symmetric(
              horizontal: context.dynamicWidht(0.065),
            ),
            decoration: BoxDecoration(color: Colors.white),
            child: Dismissible(
                direction: DismissDirection.endToStart,
                background: Padding(
                  padding: EdgeInsets.only(left: context.dynamicWidht(0.65)),
                  child: Container(
                    color: AppColors.redColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.038), horizontal: context.dynamicWidht(0.048)),
                      child: LocaleText(
                        text: LocaleKeys.my_notifications_delete_text_text,
                        style: AppTextStyles.bodyTextStyle.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        alignment: TextAlign.end,
                      ),
                    ),
                  ),
                ),
                key: UniqueKey(),
                onDismissed: (direction) {
                  setState(() {
                    value.removeAt(index);
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(top: context.dynamicHeight(0.011)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [buildTitle(context, index)[index], buildDateTrailing(context, index)[index]],
                      ),
                      Row(
                        children: [Expanded(child: buildDescriptionSubtitle(context, index)[index])],
                      ),
                    ],
                  ),
                )),
          );
        });
  }

  buildTitle(BuildContext context, index) {
    List<Widget> titleText = [];
    List<Widget> title = [
      LocaleText(
        text: LocaleKeys.my_notifications_my_orders_title,
        style: AppTextStyles.subTitleStyle,
      ),
      LocaleText(
        text: LocaleKeys.my_notifications_my_orders_title,
        style: AppTextStyles.subTitleStyle,
      ),
      LocaleText(
        text: LocaleKeys.my_notifications_my_orders_title,
        style: AppTextStyles.subTitleStyle,
      ),
      LocaleText(
        text: LocaleKeys.my_notifications_my_orders_title,
        style: AppTextStyles.subTitleStyle,
      ),
    ];

    for (int i = 0; i <= 4; i++) {
      titleText.add(title[index]);
    }
    return titleText;
  }

  buildDescriptionSubtitle(BuildContext context, index) {
    List<Widget> descriptionText = [];
    List<Widget> description = [
      courierItsWayText(context),
      forgetRateText(context),
      courierItsWayText2(context),
      forgetRateText2(context),
    ];

    for (int i = 0; i <= 4; i++) {
      descriptionText.add(description[index]);
    }
    return descriptionText;
  }

  Padding forgetRateText2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
      child: LocaleText(
        text: LocaleKeys.my_notifications_my_orders_forgetRate,
        style: AppTextStyles.bodyTextStyle.copyWith(fontWeight: FontWeight.bold, color: AppColors.textColor),
        alignment: TextAlign.start,
      ),
    );
  }

  Padding courierItsWayText2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
      child: LocaleText(
        text: LocaleKeys.my_notifications_my_orders_courierItsWay,
        style: AppTextStyles.bodyTextStyle
            .copyWith(fontWeight: FontWeight.bold, color: AppColors.textColor),
        alignment: TextAlign.start,
      ),
    );
  }

  Padding forgetRateText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
      child: LocaleText(
        text: LocaleKeys.my_notifications_my_orders_forgetRate,
        style: AppTextStyles.bodyTextStyle
            .copyWith(fontWeight: FontWeight.bold, color: AppColors.textColor),
        alignment: TextAlign.start,
      ),
    );
  }

  Padding courierItsWayText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
      child: LocaleText(
        text: LocaleKeys.my_notifications_my_orders_courierItsWay,
        style: AppTextStyles.bodyTextStyle
            .copyWith(fontWeight: FontWeight.bold, color: AppColors.textColor),
        alignment: TextAlign.start,
      ),
    );
  }

  buildDateTrailing(BuildContext context, index) {
    List<Widget> dateText = [];
    List<String> date = ["15 Mart 2021", "16 Mart 2021", "17 Mart 2021", "21 Mart 2021"];

    for (int i = 0; i <= 4; i++) {
      dateText.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LocaleText(
              text: "${date[index]}",
              style: AppTextStyles.subTitleStyle,
              alignment: TextAlign.start,
            ),
            //SizedBox(height: context.dynamicHeight(0.6),)
          ],
        ),
      );
    }
    return dateText;
  }
}

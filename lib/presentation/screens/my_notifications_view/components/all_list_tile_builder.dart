import 'package:flutter/material.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class AllListTileBuilder extends StatefulWidget {
  AllListTileBuilder({Key? key}) : super(key: key);

  @override
  _AllListTileBuilderState createState() => _AllListTileBuilderState();
}

class _AllListTileBuilderState extends State<AllListTileBuilder> {
  bool _selected = false;
  var value = <String>[
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  @override
  Widget build(BuildContext context) {
    return listViewBuilder(value);
  }

  Expanded listViewBuilder(
    List<String> value,
  ) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: value.length,
          itemBuilder: (context, index) {
            return Container(
              height: context.dynamicHeight(0.13),
              padding: EdgeInsets.symmetric(
                horizontal: context.dynamicWidht(0.065),
              ),
              decoration: BoxDecoration(
                  color: _selected
                      ? AppColors.greenColor.withOpacity(0.2)
                      : Colors
                          .white), //new notification color==> AppColors.greenColor
              child: Dismissible(
                  direction: DismissDirection.endToStart,
                  background: Padding(
                    padding: EdgeInsets.only(left: context.dynamicWidht(0.65)),
                    child: Container(
                      color: AppColors.redColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: context.dynamicHeight(0.038),
                            horizontal: context.dynamicWidht(0.058)),
                        child: LocaleText(
                          text: LocaleKeys.my_notifications_delete_text_text,
                          style: AppTextStyles.bodyTextStyle.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
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
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selected = !_selected;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.only(top: context.dynamicHeight(0.011)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildTitle(context, index)[index],
                              buildDateTrailing(context, index)[index]
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: buildDescriptionSubtitle(
                                      context, index)[index])
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            );
          }),
    );
  }

  buildTitle(BuildContext context, index) {
    List<Widget> titleText = [];
    List<Widget> title = [
      LocaleText(
        text: LocaleKeys.my_notifications_all_list_title1,
        style:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.normal),
        alignment: TextAlign.start,
      ),
      LocaleText(
        text: LocaleKeys.my_notifications_all_list_title1,
        style:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.normal),
        alignment: TextAlign.start,
      ),
      LocaleText(
        text: LocaleKeys.my_notifications_all_list_title2,
        style:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.normal),
        alignment: TextAlign.start,
      ),
      LocaleText(
        text: LocaleKeys.my_notifications_all_list_title3,
        style:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.normal),
        alignment: TextAlign.start,
      ),
      LocaleText(
        text: LocaleKeys.my_notifications_all_list_title2,
        style:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.normal),
        alignment: TextAlign.start,
      ),
      LocaleText(
        text: LocaleKeys.my_notifications_all_list_title3,
        style:
            AppTextStyles.subTitleStyle.copyWith(fontWeight: FontWeight.normal),
        alignment: TextAlign.start,
      ),
    ];

    for (int i = 0; i <= 6; i++) {
      titleText.add(title[index]);
    }
    return titleText;
  }

  buildDescriptionSubtitle(BuildContext context, index) {
    List<Widget> descriptionText = [];
    List<Widget> description = [
      lastThirtyMinsText(context),
      lastThirtyMinsApproveText(context),
      firstBuyerText(context),
      courierItsWayText(context),
      forgetRateText(context),
      firstBuyerText2(context),
    ];

    for (int i = 0; i <= 6; i++) {
      descriptionText.add(description[index]);
    }
    return descriptionText;
  }

  Padding firstBuyerText2(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
      child: LocaleText(
        text: LocaleKeys.my_notifications_all_list_firstBuyer,
        style: AppTextStyles.bodyTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
            height: 1.5),
        alignment: TextAlign.start,
      ),
    );
  }

  Padding forgetRateText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
      child: LocaleText(
        text: LocaleKeys.my_notifications_all_list_forgetRate,
        style: AppTextStyles.bodyTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
            height: 1.5),
        alignment: TextAlign.start,
      ),
    );
  }

  Padding courierItsWayText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
      child: LocaleText(
        text: LocaleKeys.my_notifications_all_list_courierItsWay,
        style: AppTextStyles.bodyTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
            height: 1.5),
        alignment: TextAlign.start,
      ),
    );
  }

  Padding firstBuyerText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
      child: LocaleText(
        text: LocaleKeys.my_notifications_all_list_firstBuyer,
        style: AppTextStyles.bodyTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
            height: 1.5),
        alignment: TextAlign.start,
      ),
    );
  }

  Padding lastThirtyMinsApproveText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
      child: LocaleText(
        text: LocaleKeys.my_notifications_all_list_lastThirtyMinsApprove,
        style: AppTextStyles.bodyTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
            height: 1.5),
        alignment: TextAlign.start,
      ),
    );
  }

  Padding lastThirtyMinsText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.01)),
      child: LocaleText(
        text: LocaleKeys.my_notifications_all_list_lastThirtyMins,
        style: AppTextStyles.bodyTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textColor,
            height: 1.5),
        alignment: TextAlign.start,
      ),
    );
  }

  buildDateTrailing(BuildContext context, index) {
    List<Widget> dateText = [];
    List<String> date = [
      "15 Mart 2021",
      "16 Mart 2021",
      "17 Mart 2021",
      "21 Mart 2021",
      "21 Mart 2021",
      "21 Mart 2021",
    ];

    for (int i = 0; i <= 6; i++) {
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

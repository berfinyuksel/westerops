import 'package:dongu_mobile/data/model/results_notification.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/get_notification_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notifications_counter_cubit/notifications_counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class MyOrdersListTileBuilder extends StatefulWidget {
  MyOrdersListTileBuilder({Key? key}) : super(key: key);

  @override
  _MyOrdersListTileBuilderState createState() =>
      _MyOrdersListTileBuilderState();
}

class _MyOrdersListTileBuilderState extends State<MyOrdersListTileBuilder> {
  @override
  Widget build(BuildContext context) {
    return buildBuilder();
  }
  @override
  void initState() {
    super.initState();
    context.read<GetNotificationCubit>().getNotification();
    
  }
  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<GetNotificationCubit>().state;

      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<Result> notifications = [];

        for (int i = 0; i < state.response.length; i++) {
          notifications.add(state.response[i]);
           context.read<NotificationsCounterCubit>().decrement();
        }

        print("STATE RESPONSE : ${state.response}");

        return Center(child: listViewBuilder(context, notifications, state));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }
  ListView listViewBuilder(
    BuildContext context,
        List<Result> notifications,
    GenericState state,
  ) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Container(
            height: 101,
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
                      padding: EdgeInsets.symmetric(
                          vertical: context.dynamicHeight(0.038),
                          horizontal: context.dynamicWidht(0.048)),
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
                    notifications.removeAt(index);
                  });
                },
                child: Container(
                  padding: EdgeInsets.only(top: context.dynamicHeight(0.011)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           buildTitle(context, index)[index],
                        //  LocaleText(
                        //     text: "${notifications[index].description}",
                        //   ),
                            LocaleText(
                            text: "${notifications[index].date}",
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: LocaleText(
                              text: "${notifications[index].message}",
                              style: AppTextStyles.bodyTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                  height: 1.5),
                              alignment: TextAlign.start,
                            ),
                          )
                        ],
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

  Padding forgetRateText2(BuildContext context) {
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
    List<String> date = [
      "15 Mart 2021",
      "16 Mart 2021",
      "17 Mart 2021",
      "21 Mart 2021"
    ];

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

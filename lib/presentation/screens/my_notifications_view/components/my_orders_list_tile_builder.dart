import 'package:dongu_mobile/data/model/results_notification.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/bulk_update_notication_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/get_notification_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notifications_counter_cubit/notifications_counter_cubit.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';
import '../../../../utils/extensions/string_extension.dart';


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
 String notificationEmpty = "Herhangi bir bildiriminiz bulunmamaktadır.";
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
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          child: Center(child: CustomCircularProgressIndicator()),
        );
      } else if (state is GenericCompleted) {
        List<Result> notifications = [];

        for (int i = 0; i < state.response.length; i++) {
          notifications.add(state.response[i]);
          context.read<NotificationsCounterCubit>().decrement();
        }

        return Center(child: notifications.isNotEmpty
                ? listViewBuilder(context, notifications, state)
                : Text(LocaleKeys.my_notifications_tab_bar_title_empty_text.locale));
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
          return notifications[index].isDeleted == false
              ? Container(
                  height: 101,
                  padding: EdgeInsets.symmetric(
                    horizontal: 28.w,
                  ),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Padding(
                        padding: EdgeInsets.only(left: 28.w),
                        child: Container(
                          color: AppColors.redColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 35.h, horizontal: 28.w),
                            child: LocaleText(
                              text:
                                  LocaleKeys.my_notifications_delete_text_text,
                              style: AppTextStyles.bodyTextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              alignment: TextAlign.end,
                            ),
                          ),
                        ),
                      ),
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        if (notifications.isNotEmpty) {
                          context
                              .read<BulkUpdateNotificationCubit>()
                              .putNotification(
                                  notifications[index].id.toString());
                          notifications.removeAt(index);
                          context
                              .read<GetNotificationCubit>()
                              .getNotification();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            notificationTitleAndDate(notifications, index),
                            notificationSubtitle(context, notifications, index),
                          ],
                        ),
                      )),
                )
              : SizedBox();
        });
  }

  Expanded notificationSubtitle(
      BuildContext context, List<Result> notifications, int index) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
              child: Text(
            "${notifications[index].message}",
            style: AppTextStyles.subTitleStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
                height: 2.5.h),
            textAlign: TextAlign.start,
          ))
        ],
      ),
    );
  }

  notificationTitleAndDate(List<Result> notifications, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 10,
          child: Text(
            notifications[index].type == 16 ||
                    notifications[index].type == 15 ||
                    notifications[index].type == 14 ||
                    notifications[index].type == 13 ||
                    notifications[index].type == 11 ||
                    notifications[index].type == 8
                ? "🔔 ${notifications[index].description}"
                : notifications[index].type == 10 ||
                        notifications[index].type == 9
                    ? "🎉 ${notifications[index].description}"
                    : "🛒 ${notifications[index].description}",
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Text(
          "${notifications[index].date}",
        )
      ],
    );
  }
}

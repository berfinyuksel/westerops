import 'package:dongu_mobile/data/model/results_notification.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/bulk_update_notication_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/get_notification_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notifications_counter_cubit/notifications_counter_cubit.dart';
import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/constants/image_constant.dart';
import '../../../../utils/extensions/context_extension.dart';
import '../../../../utils/locale_keys.g.dart';
import '../../../../utils/theme/app_colors/app_colors.dart';
import '../../../../utils/theme/app_text_styles/app_text_styles.dart';
import '../../../widgets/text/locale_text.dart';

class SpecialForMeListTileBuilder extends StatefulWidget {
  SpecialForMeListTileBuilder({Key? key}) : super(key: key);

  @override
  _SpecialForMeListTileBuilderState createState() =>
      _SpecialForMeListTileBuilderState();
}

class _SpecialForMeListTileBuilderState
    extends State<SpecialForMeListTileBuilder> {
  var value = <String>["", "", "", ""];

  @override
  Widget build(BuildContext context) {
    return buildBuilder();
  }

  @override
  void initState() {
    context.read<GetNotificationCubit>().getNotification();
    super.initState();
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<GetNotificationCubit>().state;

      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: context.dynamicHeight(0.3)),
          child: Center(child: CustomCircularProgressIndicator()),
        );
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

          return notifications[index].isDeleted == false ? Container(
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
                       if (notifications.isNotEmpty ) {
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
                child: Container(
                  padding: EdgeInsets.only(
                    top: context.dynamicHeight(0.011),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //buildTitle(context, index)[index],
                            //buildDateTrailing(context, index)[index]
                            Expanded(
                              flex:5,
                              child: LocaleText(
                                text: notifications[index].type == 16 || notifications[index].type == 15 || notifications[index].type == 14 || notifications[index].type == 13 || notifications[index].type == 11 || notifications[index].type == 8  ? "🔔 ${notifications[index].description}" :  notifications[index].type == 10 || notifications[index].type == 9 ? "🎉 ${notifications[index].description}" : "🛒 ${notifications[index].description}"
                                ,
                              ),
                            ),
                            LocaleText(
                              text: "${notifications[index].date}",
                            )
                          ],
                        ),
                      ),
                      //Spacer(flex:1),
                      Expanded(
                        flex:2,
                        child: Row(
                          children: [
                            buildIconsLeading(
                                context, index, notifications)[index],
                                SizedBox(width: 10,),
                            Expanded(
                                child: LocaleText(
                              text: "${notifications[index].message}",
                              style: AppTextStyles.bodyTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textColor,
                                  height: 1.5),
                              alignment: TextAlign.start,
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ) : Text("");
        });
  }

  buildIconsLeading(BuildContext context, index, List<Result> notifications) {
    List<Widget> containerIcon = [];
    List<Widget> icons = [
      SvgPicture.asset(ImageConstant.NOTIFICATIONS_DISCOUNT_50_ICON),
      SvgPicture.asset(ImageConstant.NOTIFICATIONS_DISCOUNT_70_ICON),
      Padding(
        padding: EdgeInsets.all(context.dynamicHeight(0.007)),
        child: SvgPicture.asset(ImageConstant.NOTIFICATIONS_ITSELF_ICON),
      ),
      Padding(
        padding: EdgeInsets.all(context.dynamicHeight(0.007)),
        child: SvgPicture.asset(ImageConstant.NOTIFICATIONS_LIKE_ICON),
      ),
    ];

    for (int i = 0; i < notifications.length; i++) {
      if (notifications[index].type == 16 ||
          notifications[index].type == 15 ||
          notifications[index].type == 14 ||
          notifications[index].type == 13 ||
          notifications[index].type == 11 ||
          notifications[index].type == 8  ) {
            //The icon will change according to notifications. notifications are currently in testing
         containerIcon.add(
          Container(
            width: context.dynamicWidht(0.11),
            height: context.dynamicHeight(0.052),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white,
              border: Border.all(
                width: 2.0,
                color: AppColors.borderAndDividerColor,
              ),
            ),
            child: icons[3],
          ),
        );
      }else{
            containerIcon.add(
          Container(
            width: context.dynamicWidht(0.11),
            height: context.dynamicHeight(0.052),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: Colors.white,
              border: Border.all(
                width: 2.0,
                color: AppColors.borderAndDividerColor,
              ),
            ),
            child: icons[3],
          ),
        );
      }
      // containerIcon.add(
      //   Container(
      //     width: context.dynamicWidht(0.11),
      //     height: context.dynamicHeight(0.052),
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(4.0),
      //       color: Colors.white,
      //       border: Border.all(
      //         width: 2.0,
      //         color: AppColors.borderAndDividerColor,
      //       ),
      //     ),
      //     child: icons.first,
      //   ),
      // );
    }
    return containerIcon;
  }

}

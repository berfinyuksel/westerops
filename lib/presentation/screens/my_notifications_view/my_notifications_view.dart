import 'package:dongu_mobile/data/model/results_notification.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/get_notification_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notifications_counter_cubit/notifications_counter_cubit.dart';
import 'package:dongu_mobile/presentation/screens/my_notifications_view/empty_my_notifications_view.dart';

import 'package:dongu_mobile/presentation/widgets/circular_progress_indicator/custom_circular_progress_indicator.dart';
import 'package:dongu_mobile/presentation/widgets/text/locale_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/extensions/context_extension.dart';
import '../../../utils/extensions/string_extension.dart';
import '../../../utils/locale_keys.g.dart';
import '../../../utils/theme/app_colors/app_colors.dart';
import '../../../utils/theme/app_text_styles/app_text_styles.dart';
import 'components/all_list_tile_builder.dart';
import 'components/my_orders_list_tile_builder.dart';
import 'components/special_for_me_list_tile_builder.dart';

class MyNotificationsView extends StatefulWidget {
  MyNotificationsView({Key? key}) : super(key: key);

  @override
  _MyNotificationsViewState createState() => _MyNotificationsViewState();
}

class _MyNotificationsViewState extends State<MyNotificationsView>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  void notificationToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    notificationToken();
    context.read<GetNotificationCubit>().getNotification();
    // notificationToken();
    //  context.read<NotificationCubit>().getNotification();
  }

  @override
  Widget build(BuildContext context) {
    if (SharedPrefs.getIsLogined == false) {
      return EmptyMyNotificationsView();
    } else {
      return buildBody(context);
    }
  }

  Builder buildBuilder() {
    return Builder(builder: (context) {
      final GenericState state = context.watch<GetNotificationCubit>().state;

      if (state is GenericInitial) {
        return Container();
      } else if (state is GenericLoading) {
        return Center(child: CustomCircularProgressIndicator());
      } else if (state is GenericCompleted) {
        List<Result> notifications = [];

        for (int i = 0; i < state.response.length; i++) {
          notifications.add(state.response[i]);
          context.read<NotificationsCounterCubit>().increment();
        }

        return Center(child: buildBody(context));
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  Column buildBody(BuildContext context) {
    return Column(
      children: [
        tabBarPadding(context),
        Expanded(
          child: TabBarView(controller: _controller, children: [
            MyOrdersListTileBuilder(),
            AllListTileBuilder(),
            SpecialForMeListTileBuilder(),
          ]),
        ),
      ],
    );
  }

  Padding tabBarPadding(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28.w,
        right: 28.w,
        top: 20.h,
      ),
      child: tabBarContainer(context),
    );
  }

  Container tabBarContainer(BuildContext context) {
    return Container(
      width: 372.w,
      height: 83.h,
      padding: EdgeInsets.only(top: 7.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18.0),
          bottom: Radius.circular(8.0),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          // SizedBox(height: 3,),
          tabBar(context),
          Spacer(
            flex: 1,
          ),
          Divider(
            thickness: 2,
            height: 0,
            color: AppColors.borderAndDividerColor,
          ),
        ],
      ),
    );
  }

  TabBar tabBar(BuildContext context) {
    return TabBar(
        labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 3, color: AppColors.orangeColor),
            insets:
                EdgeInsets.symmetric(horizontal: context.dynamicWidht(0.060))),
        indicatorPadding: EdgeInsets.only(bottom: context.dynamicHeight(0.005)),
        labelColor: AppColors.orangeColor,
        labelStyle: AppTextStyles.bodyTitleStyle,
        unselectedLabelColor: AppColors.textColor,
        unselectedLabelStyle: GoogleFonts.montserrat(
          decoration: TextDecoration.none,
          fontSize: 16.0.sp,
          color: AppColors.textColor,
          fontWeight: FontWeight.w300,
          height: 2.5.h,
        ),
        indicatorColor: AppColors.orangeColor,
        controller: _controller,
        isScrollable: true,
        tabs: [
          Tab(text: LocaleKeys.my_notifications_tab_bar_title_title1.locale),
          Tab(
            text: LocaleKeys.my_notifications_tab_bar_title_title2.locale,
          ),
          Tab(
            text: LocaleKeys.my_notifications_tab_bar_title_title3.locale,
          ),
        ]);
  }
}

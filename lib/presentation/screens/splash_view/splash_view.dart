import 'package:dongu_mobile/data/model/results_notification.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/generic_state/generic_state.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/get_notification_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notifications_counter_cubit/notifications_counter_cubit.dart';
import 'package:dongu_mobile/presentation/widgets/scaffold/custom_scaffold.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/image_constant.dart';
import '../onboardings_view/onboardings_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  int? counterState;

  @override
  void initState() {
    super.initState();
    setState(() {
      SharedPrefs.getIsOnboardingShown;
    });
    //SharedPrefs.setCounterNotifications(counterState! + 1);
    Future.delayed(
        Duration(
          milliseconds: 5600,
        ), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OnboardingsView()));
          if (SharedPrefs.getIsLogined) {
        SharedPrefs.clearCache();
        // Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
         Navigator.push(context,
            MaterialPageRoute(builder: (context) => CustomScaffold()));
          }
    });
    Future.delayed(
        Duration(
          days: 30,
        ), () {
      if (SharedPrefs.getIsLogined) {
        SharedPrefs.clearCache();
        // Navigator.pushNamed(context, RouteConstant.CUSTOM_SCAFFOLD);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CustomScaffold()));
      }
    });
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
           SharedPrefs.setCounterNotifications(notifications.length);
           context.read<NotificationsCounterCubit>().increment();
        }
        SharedPrefs.setCounterNotifications(notifications.length);


        print("STATE RESPONSE : ${state.response}");

        return  Container(
          width: double.infinity,
          child: LottieBuilder.asset(
            ImageConstant.SPLASH_ANIMATION,
            fit: BoxFit.cover,
          ),
        );
      } else {
        final error = state as GenericError;
        return Center(child: Text("${error.message}\n${error.statusCode}"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: buildBuilder());
  }
}

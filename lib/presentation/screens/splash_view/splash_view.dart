import 'package:dongu_mobile/logic/cubits/splash_cubit/splash_cubit.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SplashCubit>(
            create: (context) => SplashCubit()..splashInit(context),
          ),
        ],
        child: Scaffold(body: BlocBuilder<SplashCubit, SplashCubitState>(
          builder: (context, state) {
            if (state is SplashCubitInitial) {
              return SizedBox();
            } else if (state is SplashCubitLoading) {
              
              return Container(
                width: double.infinity, 
                child: LottieBuilder.asset(
                  ImageConstant.SPLASH_ANIMATION,
                  repeat: false,
                  fit: BoxFit.cover,
                ),
              );
            } else {
              return Center(
                child: Text('hello splash'),
              );
            }
          },
        )));
  }
}

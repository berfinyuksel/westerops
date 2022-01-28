import 'package:dongu_mobile/data/repositories/search_store_repository.dart';
import 'package:dongu_mobile/data/services/locator.dart';
import 'package:dongu_mobile/data/shared/shared_prefs.dart';
import 'package:dongu_mobile/logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/favourite_cubit/favourite_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notifications_counter_cubit/notifications_counter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/order_bar_cubit/order_bar_cubit.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_old_price_order_cubit.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_price_order_cubit.dart';
import 'package:dongu_mobile/presentation/router/app_router.dart';
import 'package:dongu_mobile/utils/theme/app_theme.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'image_svg_onboarding.dart';
import 'multi_bloc_provider.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  void initState() {

    super.initState();
    Future.wait(svgImageListOnboarding);

  }
@override
  void didChangeDependencies() async{

    super.didChangeDependencies();
    await sl<SampleSearchStoreRepository>().getSearchStores();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: multiBlocProvider,
      child: Builder(builder: (context) {
        context.read<BasketCounterCubit>().setCounter(SharedPrefs.getCounter);
        context
            .read<NotificationsCounterCubit>()
            .setCounter(SharedPrefs.getCounter);

        for (var i = 0; i < SharedPrefs.getFavorites.length; i++) {
          context
              .read<FavoriteCubit>()
              .addFavorite(int.parse(SharedPrefs.getFavorites[i]));
        }
        context.read<OrderBarCubit>().stateOfBar(SharedPrefs.getOrderBar);

        context
            .read<SumPriceOrderCubit>()
            .incrementPrice(SharedPrefs.getSumPrice);
        context
            .read<SumOldPriceOrderCubit>()
            .incrementOldPrice(SharedPrefs.getOldSumPrice);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Döngü',
          theme: appThemeData[AppTheme.PrimaryTheme],
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: _appRouter.onGenerateRoute,
          // locale: DevicePreview.locale(context),
          // useInheritedMediaQuery: true,
          // builder: DevicePreview.appBuilder,
          //home: HomeScreen(),
        );
      }),
    );
  }
}

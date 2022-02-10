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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'svg_image_repository.dart';
import 'bloc_provider_repository.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await sl<SvgImageRepository>().preCacheSvgPictures();
    await sl<SampleSearchStoreRepository>().getSearchStores();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: sl<BlocProviderRepository>().multiBlocProvider,
      child: ScreenUtilInit(
        designSize: Size(428, 926),
        builder: () => MaterialApp(
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
        ),
      ),
    );
  }
}

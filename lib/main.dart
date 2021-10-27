import 'dart:io';

import 'package:dongu_mobile/data/repositories/address_repository.dart';
import 'package:dongu_mobile/data/repositories/search_store_repository.dart';
import 'package:dongu_mobile/data/repositories/store_boxes_repository.dart';
import 'package:dongu_mobile/data/repositories/user_address_repository.dart';
import 'package:dongu_mobile/logic/cubits/address_cubit/address_cubit.dart';
import 'package:dongu_mobile/logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/box_cubit/box_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'package:dongu_mobile/logic/cubits/store_boxes_cubit/store_boxes_cubit.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_price_order_cubit.dart';
import 'package:dongu_mobile/logic/cubits/user_address_cubit/user_address_cubit.dart';
import 'package:dongu_mobile/data/repositories/search_repository.dart';
import 'package:dongu_mobile/logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/box_cubit/box_cubit.dart';
import 'package:dongu_mobile/logic/cubits/search_cubit/search_cubit.dart';

import 'package:dongu_mobile/presentation/screens/filter_view/filter_view.dart';
import 'package:dongu_mobile/presentation/screens/forgot_password_view/forgot_password_view.dart';
import 'package:dongu_mobile/presentation/screens/home_page_view/home_page_view.dart';
import 'package:dongu_mobile/presentation/screens/login_view/login_view.dart';
import 'package:dongu_mobile/presentation/screens/register_view/register_view.dart';
import 'package:dongu_mobile/presentation/screens/restaurant_details_views/restaurant_detail_view/restaurant_detail_view.dart';
import 'package:dongu_mobile/presentation/screens/splash_view/splash_view.dart';
import 'package:dongu_mobile/presentation/screens/surprise_pack_view/surprise_pack_view.dart';
import 'package:dongu_mobile/presentation/screens/swipe_view/swipe_view.dart';
import 'package:dongu_mobile/utils/constants/image_constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories/box_repository.dart';
import 'data/repositories/order_repository.dart';

import 'data/repositories/search_location_repository.dart';

import 'data/repositories/user_authentication_repository.dart';
import 'data/repositories/user_operatios_repository.dart';
import 'data/services/locator.dart';
import 'data/shared/shared_prefs.dart';
import 'logic/cubits/filters_cubit/filters_cubit.dart';
import 'logic/cubits/order_cubit/order_cubit.dart';
import 'logic/cubits/payment_cubit/payment_cubit.dart';
import 'logic/cubits/search_location_cubit/search_location_cubit.dart';

import 'logic/cubits/user_auth_cubit/user_auth_cubit.dart';
import 'logic/cubits/user_operations_cubit/user_operations_cubit.dart';
import 'presentation/router/app_router.dart';
import 'utils/constants/locale_constant.dart';
import 'utils/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setUpLocator();
  await EasyLocalization.ensureInitialized();
  await SharedPrefs.initialize();
  await Firebase.initializeApp();
  //fixed late arriving svg with future.wait function
  Future.wait([
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder,
          'assets/images/permissions/location_image.svg'),
      null,
    ),
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder,
          'assets/images/permissions/notification_image.svg'),
      null,
    ),
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder,
          'assets/images/onboardings/onboarding_forth/onboarding_forth_background.svg'),
      null,
    ),
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder,
          'assets/images/order_receiving/background.svg'),
      null,
    ),

    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder,
          'assets/images/order_receiving/receiving_dongu_logo.svg'),
      null,
    ),
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoder,
          'assets/images/order_receiving/receiving_package_icon.svg'),
      null,
    ),
    // other SVGs or images here
  ]);
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    EasyLocalization(
      path: LocaleConstant.LANG_PATH,
      supportedLocales: LocaleConstant.SUPPORTED_LOCALES,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BasketCounterCubit>(create: (_) => BasketCounterCubit()),
        BlocProvider<SumPriceOrderCubit>(create: (_) => SumPriceOrderCubit()),
        BlocProvider<SearchLocationCubit>(
            create: (context) =>
                SearchLocationCubit(SampleSearchLocationRepository())),
        BlocProvider<SearchStoreCubit>(
            create: (context) =>
                SearchStoreCubit(SampleSearchStoreRepository())),
        BlocProvider<StoreBoxesCubit>(
            create: (context) => StoreBoxesCubit(SampleStoreBoxesRepository())),
        BlocProvider<SearchCubit>(
            create: (context) => SearchCubit(SampleSearchRepository())),
        BlocProvider<BoxCubit>(
            create: (context) => BoxCubit(SampleBoxRepository())),
        BlocProvider<UserAuthCubit>(
            create: (context) =>
                UserAuthCubit(SampleUserAuthenticationRepository())),
        BlocProvider<OrderCubit>(
            create: (context) => OrderCubit(SampleOrderRepository())),
        BlocProvider<UserOperationsCubit>(
            create: (context) =>
                UserOperationsCubit(SampleUserOperationsRepository())),
        BlocProvider<AddressCubit>(
            create: (context) => AddressCubit(SampleAdressRepository())),
        BlocProvider<UserAddressCubit>(
            create: (context) =>
                UserAddressCubit(SampleUserAdressRepository())),
        BlocProvider<PaymentCubit>(create: (context) => PaymentCubit()),
        BlocProvider<FiltersCubit>(create: (context) => FiltersCubit())
      ],
      child: Builder(builder: (context) {
        context.read<BasketCounterCubit>().setCounter(SharedPrefs.getCounter);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dongu App',
          theme: appThemeData[AppTheme.PrimaryTheme],
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: _appRouter.onGenerateRoute,
          //home: SwipeView(),
        );
      }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

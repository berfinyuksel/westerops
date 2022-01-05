import 'dart:io';

import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_card_repository.dart';
import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_creat_order_with_3d.dart';
import 'package:dongu_mobile/data/repositories/iyzico_repositories/iyzico_send_request_repository.dart';
import 'package:dongu_mobile/data/services/ip_service.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_card_cubit/iyzico_card_cubit.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_order_create_with_3d_cubit/iyzico_order_create_with_3d_cubit.dart';
import 'package:dongu_mobile/logic/cubits/iyzico_send_request_cubit.dart/iyzico_send_request_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dongu_mobile/logic/cubits/notificaiton_cubit/notification_cubit.dart';
import 'package:dongu_mobile/logic/cubits/notifications_counter_cubit/notifications_counter_cubit.dart';
import 'package:dongu_mobile/logic/cubits/padding_values_cubit/category_padding_values_cubit.dart';
import 'package:dongu_mobile/logic/cubits/padding_values_cubit/near_me_padding_values.dart';
import 'package:dongu_mobile/logic/cubits/padding_values_cubit/opportunity_padding_values.dart';
import 'package:dongu_mobile/logic/cubits/sum_price_order_cubit/sum_old_price_order_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'data/repositories/address_repository.dart';
import 'data/repositories/avg_review_repository.dart';
import 'data/repositories/box_repository.dart';
import 'data/repositories/category_name_repository.dart';
import 'data/repositories/favourite_repository.dart';
import 'data/repositories/filters_repository.dart';
import 'data/repositories/get_notification_repository.dart';
import 'data/repositories/notification_repository.dart';
import 'data/repositories/order_received_repository.dart';
import 'data/repositories/order_repository.dart';
import 'data/repositories/put_notification_repository.dart';
import 'data/repositories/search_location_repository.dart';
import 'data/repositories/search_repository.dart';
import 'data/repositories/search_store_repository.dart';
import 'data/repositories/store_boxes_repository.dart';
import 'data/repositories/store_courier_hours_repository.dart';
import 'data/repositories/time_interval_repository.dart';
import 'data/repositories/user_address_repository.dart';
import 'data/repositories/user_authentication_repository.dart';
import 'data/services/local_notifications/local_notifications_service/local_notifications_service.dart';
import 'data/services/locator.dart';
import 'data/shared/shared_prefs.dart';
import 'logic/cubits/address_cubit/address_cubit.dart';
import 'logic/cubits/avg_review_cubit/avg_review_cubit.dart';
import 'logic/cubits/basket_counter_cubit/basket_counter_cubit.dart';
import 'logic/cubits/box_cubit/box_cubit.dart';
import 'logic/cubits/category_name_cubit/category_name_cubit.dart';
import 'logic/cubits/favourite_cubit/favourite_cubit.dart';
import 'logic/cubits/filters_cubit/filters_cubit.dart';
import 'logic/cubits/filters_cubit/filters_manager_cubit.dart';
import 'logic/cubits/filters_cubit/sort_filters_cubit.dart';
import 'logic/cubits/notificaiton_cubit/get_notification_cubit.dart';
import 'logic/cubits/notificaiton_cubit/put_notification_cubit.dart';
import 'logic/cubits/order_bar_cubit/order_bar_cubit.dart';
import 'logic/cubits/order_cubit/order_cubit.dart';
import 'logic/cubits/order_cubit/order_received_cubit.dart';
import 'logic/cubits/payment_cubit/payment_cubit.dart';
import 'logic/cubits/search_cubit/search_cubit.dart';
import 'logic/cubits/search_location_cubit/search_location_cubit.dart';
import 'logic/cubits/search_store_cubit/search_store_cubit.dart';
import 'logic/cubits/social_login_cubit/social_login_cubit.dart';
import 'logic/cubits/store_boxes_cubit/store_boxes_cubit.dart';
import 'logic/cubits/store_courier_hours_cubit/store_courier_hours_cubit.dart';
import 'logic/cubits/sum_price_order_cubit/sum_price_order_cubit.dart';
import 'logic/cubits/time_interval_cubit/time_interval_cubit.dart';
import 'logic/cubits/user_address_cubit/user_address_cubit.dart';
import 'logic/cubits/user_auth_cubit/user_auth_cubit.dart';
import 'presentation/router/app_router.dart';
import 'utils/constants/locale_constant.dart';
import 'utils/theme/app_theme.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  NotificationService().init();
  await setUpLocator();
  await EasyLocalization.ensureInitialized();
  await SharedPrefs.initialize();
  await Firebase.initializeApp();
  await IpService().detectIP();
  //fixed late arriving svg with future.wait function
  Future.wait([
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
          'assets/images/permissions/location_image.svg'),
      null,
    ),
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
          'assets/images/permissions/notification_image.svg'),
      null,
    ),
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
          'assets/images/onboardings/onboarding_forth/onboarding_forth_background.svg'),
      null,
    ),
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
          'assets/images/order_receiving/background.svg'),
      null,
    ),

    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
          'assets/images/order_receiving/receiving_dongu_logo.svg'),
      null,
    ),
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
          'assets/images/order_receiving/receiving_package_icon.svg'),
      null,
    ),
    precachePicture(
      ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
          'assets/images/food_waste/food_waste_symbol.svg'),
      null,
    ),
    // other SVGs or images here
  ]);
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    EasyLocalization(
      child: MyApp(),
      // child: DevicePreview(
      //   builder: (context) => MyApp(),
      //   enabled: !kReleaseMode,
      // ),
      path: LocaleConstant.LANG_PATH,
      supportedLocales: LocaleConstant.SUPPORTED_LOCALES,
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
        BlocProvider<NotificationsCounterCubit>(
            create: (_) => NotificationsCounterCubit()),
        BlocProvider<NearMePaddingCubit>(create: (_) => NearMePaddingCubit()),
        BlocProvider<IyzicoCardCubit>(
            create: (_) => IyzicoCardCubit(IyzicoCardRepository())),
        BlocProvider<IyzicoOrderCreateWith3DCubit>(
            create: (_) => IyzicoOrderCreateWith3DCubit(
                IyzicoCreateOrderWith3DRepository())),
        BlocProvider<OpportunityPaddingCubit>(
            create: (_) => OpportunityPaddingCubit()),
        BlocProvider<CategoryPaddingCubit>(
            create: (_) => CategoryPaddingCubit()),
        BlocProvider<OrderBarCubit>(create: (_) => OrderBarCubit()),
        BlocProvider<SocialLoginCubit>(create: (_) => SocialLoginCubit()),
        BlocProvider<SumPriceOrderCubit>(create: (_) => SumPriceOrderCubit()),
        BlocProvider<SumOldPriceOrderCubit>(
            create: (_) => SumOldPriceOrderCubit()),
        BlocProvider<SortFilterCubit>(create: (_) => SortFilterCubit()),
        BlocProvider<SearchLocationCubit>(
            create: (context) =>
                SearchLocationCubit(SampleSearchLocationRepository())),
        BlocProvider<SendRequestCubit>(
            create: (context) =>
                SendRequestCubit(SampleSendRequestRepository())),
        BlocProvider<NotificationCubit>(
            create: (context) =>
                NotificationCubit(SampleNotificationRepository())),
        BlocProvider<GetNotificationCubit>(
            create: (context) =>
                GetNotificationCubit(SampleGetNotificationRepository())),
        BlocProvider<PutNotificationCubit>(
            create: (context) =>
                PutNotificationCubit(SamplePutNotificationRepository())),
        BlocProvider<TimeIntervalCubit>(
            create: (context) =>
                TimeIntervalCubit(SampleTimeIntervalRepository())),
        BlocProvider<AvgReviewCubit>(
            create: (context) => AvgReviewCubit(AvgReviewRepository())),
        BlocProvider<OrderReceivedCubit>(
            create: (context) =>
                OrderReceivedCubit(SampleOrderReceivedRepository())),
        BlocProvider<StoreCourierCubit>(
            create: (context) =>
                StoreCourierCubit(SampleStoreCourierHoursRepository())),
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
        BlocProvider<FavoriteCubit>(
            create: (context) => FavoriteCubit(SampleFavoriteRepository())),
        BlocProvider<CategoryNameCubit>(
            create: (context) =>
                CategoryNameCubit(SampleCategoryNameRepository())),
        BlocProvider<AddressCubit>(
            create: (context) => AddressCubit(SampleAdressRepository())),
        BlocProvider<UserAddressCubit>(
            create: (context) =>
                UserAddressCubit(SampleUserAdressRepository())),
        BlocProvider<PaymentCubit>(create: (context) => PaymentCubit()),
        BlocProvider<FiltersCubit>(create: (context) => FiltersCubit()),
        BlocProvider<FiltersManagerCubit>(
            create: (context) =>
                FiltersManagerCubit(SampleFiltersRepository())),
      ],
      child: Builder(builder: (context) {
        context.read<BasketCounterCubit>().setCounter(SharedPrefs.getCounter);

        context
            .read<NotificationsCounterCubit>()
            .setCounter(SharedPrefs.getCounter);

        List<int> sumPrices = [];
        for (var i = 0; i < SharedPrefs.getSumPrice.length; i++) {
          sumPrices.add(int.parse(SharedPrefs.getSumPrice[i]));
        }
        context.read<SumPriceOrderCubit>().sumprice(sumPrices);
        List<int> sumOldPrices = [];
        for (var i = 0; i < SharedPrefs.getSumOldPrice.length; i++) {
          sumOldPrices.add(int.parse(SharedPrefs.getSumOldPrice[i]));
        }
        context.read<SumPriceOrderCubit>().sumprice(sumOldPrices);
        for (var i = 0; i < SharedPrefs.getFavorites.length; i++) {
          context
              .read<FavoriteCubit>()
              .addFavorite(int.parse(SharedPrefs.getFavorites[i]));
        }
        context.read<OrderBarCubit>().stateOfBar(SharedPrefs.getOrderBar);

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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

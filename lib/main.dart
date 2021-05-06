import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/order_repository.dart';
import 'data/repositories/search_location_repository.dart';
import 'data/repositories/store_repository.dart';
import 'data/repositories/user_authentication_repository.dart';
import 'data/repositories/user_operatios_repository.dart';
import 'data/shared/shared_prefs.dart';
import 'logic/cubits/filters_cubit/filters_cubit.dart';
import 'logic/cubits/order_cubit/order_cubit.dart';
import 'logic/cubits/payment_cubit/payment_cubit.dart';
import 'logic/cubits/search_location_cubit/search_location_cubit.dart';
import 'logic/cubits/store_cubit/store_cubit.dart';
import 'logic/cubits/user_auth_cubit/user_auth_cubit.dart';
import 'logic/cubits/user_operations_cubit/user_operations_cubit.dart';
import 'presentation/router/app_router.dart';
import 'utils/constants/locale_constant.dart';
import 'utils/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await SharedPrefs.initialize();
  await Firebase.initializeApp();

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
        BlocProvider<SearchLocationCubit>(create: (context) => SearchLocationCubit(SampleSearchLocationRepository())),
        BlocProvider<StoreCubit>(create: (context) => StoreCubit(SampleStoreRepository())),
        BlocProvider<UserAuthCubit>(create: (context) => UserAuthCubit(SampleUserAuthenticationRepository())),
        BlocProvider<OrderCubit>(create: (context) => OrderCubit(SampleOrderRepository())),
        BlocProvider<UserOperationsCubit>(create: (context) => UserOperationsCubit(SampleUserOperationsRepository())),
        BlocProvider<PaymentCubit>(create: (context) => PaymentCubit()),
        BlocProvider<FiltersCubit>(create: (context) => FiltersCubit())
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dongu App',
          theme: appThemeData[AppTheme.PrimaryTheme],
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: _appRouter.onGenerateRoute,
        );
      }),
    );
  }
}

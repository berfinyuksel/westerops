import 'data/repositories/search_location_repository.dart';
import 'logic/cubits/payment_cubit/payment_cubit.dart';
import 'logic/cubits/search_location_cubit/search_location_cubit.dart';
import 'utils/constants/locale_constant.dart';
import 'utils/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/shared/shared_prefs.dart';
import 'logic/cubits/filters_cubit/filters_cubit.dart';
import 'presentation/router/app_router.dart';

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
        BlocProvider<SearchLocationCubit>(
            create: (context) =>
                SearchLocationCubit(SampleSearchLocationRepository())),
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

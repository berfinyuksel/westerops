import 'package:dongu_mobile/presentation/screens/filter_view/filter_view.dart';
import 'package:dongu_mobile/presentation/screens/permissions_views/location_view/location.dart';
import 'package:dongu_mobile/presentation/screens/permissions_views/notification_view/notification.dart';
import 'package:dongu_mobile/presentation/screens/search_view/search.dart';
import 'package:dongu_mobile/utils/constants/locale_constant.dart';
import 'package:dongu_mobile/utils/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'presentation/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dongu App',
      theme: appThemeData[AppTheme.PrimaryTheme],
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: _appRouter.onGenerateRoute,
      home: FilterView(),
    );

    /*MultiBlocProvider(
      providers: [],
      child: Builder(builder: (context) {
        return
        
      }),
    );*/
  }
}

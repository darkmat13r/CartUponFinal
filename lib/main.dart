import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coupon_app/app/pages/login/login_view.dart';
import 'package:coupon_app/app/pages/welcome/welcome_view.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:easy_localization/easy_localization.dart';
void main() {
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations', // <-- change patch to your
      fallbackLocale: Locale('en'),
      assetLoader: RootBundleAssetLoader(),
      child: MyApp()
  ),);
}

class MyApp extends StatelessWidget {
  final AppRouter _router;

  MyApp():_router  = AppRouter(){
    initLogger();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme(context),
      home: LoginPage(),
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
  void initLogger() {

  }
}


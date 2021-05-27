import 'package:coupon_app/app/pages/splash/splash_view.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coupon_app/app/pages/login/login_view.dart';
import 'package:coupon_app/app/pages/welcome/welcome_view.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Locale userSelectedLocale = await SessionHelper().getLanguage();
  Config().locale = userSelectedLocale;
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations', // <-- change patch to your
      fallbackLocale: userSelectedLocale,
      assetLoader: RootBundleAssetLoader(),
      child: Phoenix(
        child: MyApp(userSelectedLocale),
      )
  ),);
}

class MyApp extends StatelessWidget {
  final AppRouter _router;
  final Locale _userSelectedLocale;
  MyApp(this._userSelectedLocale):_router  = AppRouter(){
    initLogger();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var locale = Config().locale != null ? Config().locale : context.deviceLocale;

    EasyLocalization.of(context).setLocale(locale);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme(context),
      home: SplashPage(),
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


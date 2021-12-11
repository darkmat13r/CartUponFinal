import 'dart:io';

import 'package:coupon_app/app/pages/error/something_went_wrong.dart';
import 'package:coupon_app/app/pages/splash/splash_view.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/deeplink_helper.dart';
import 'package:coupon_app/app/utils/theme_data.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coupon_app/app/pages/login/login_view.dart';
import 'package:coupon_app/app/pages/welcome/welcome_view.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:pushwoosh/pushwoosh.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();


  Locale userSelectedLocale = await SessionHelper().getLanguage();

  Config().locale = userSelectedLocale ?? Locale('en');
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        // <-- change patch to your
        fallbackLocale: userSelectedLocale,
        assetLoader: RootBundleAssetLoader(),
        child: Phoenix(
          child: MyApp(userSelectedLocale),
        )),
  );
}

class MyApp extends StatefulWidget {
  final Locale _userSelectedLocale;

  MyApp(this._userSelectedLocale) {}

  @override
  State<StatefulWidget> createState() => MyAppState(_userSelectedLocale);
}

class MyAppState extends State<MyApp> {
  final AppRouter _router;
  final Locale _userSelectedLocale;


  MyAppState(this._userSelectedLocale) : _router = AppRouter() {
    initLogger();
  }

  initialize() async{
    var deviceLocale = context.deviceLocale;
    if (deviceLocale.languageCode.contains("en") ||
        deviceLocale.languageCode.contains("ar")) {
      try {
        var parts = ["en"];
        var p = deviceLocale.languageCode.split(Platform.isAndroid ? "_" : "-");
        if (p.length > 0) {
          parts = p;
        }
        deviceLocale = Locale(parts[0]);
      } catch (e) {
        deviceLocale = Locale("en");
      }
    } else {
      deviceLocale = Locale("en");
    }
    var locale = Config().locale != null ? Config().locale : deviceLocale;
    EasyLocalization.of(context).setLocale(locale);
    await Firebase.initializeApp();
    Pushwoosh.initialize({"app_id": "EE86C-B7FB7", "sender_id": "244170329800"});

    Pushwoosh pushwoosh = Pushwoosh.getInstance;
    await pushwoosh.registerForPushNotifications();
    pushwoosh.setShowForegroundAlert(true);
    pushwoosh.onPushReceived.listen((event) {
      var message = event.pushwooshMessage;
      Logger().e("onPushReceived" + message.payload.toString());
    });
    pushwoosh.onPushAccepted.listen((event) {
      var message = event.pushwooshMessage;
      Logger().e("onPushAccepted" + message.payload.toString());
    });

    pushwoosh.setShowForegroundAlert(true);

    return Future(null);
  }

  final _splashPage = SplashPage();
  @override
  Widget build(BuildContext context) {
    //return _myApp();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: initialize(),
      builder: (context, snapshot) {
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return _myApp();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return _splashPage;
      },
    );
  }

    _myApp(){
      FirebaseAnalytics analytics = FirebaseAnalytics();
      return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: appTheme(context),
          home: SplashPage(),
          onGenerateRoute: _router.getRoute,
          navigatorObservers: [_router.routeObserver, FirebaseAnalyticsObserver(analytics: analytics),],
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        ),
      );

    }

  void initLogger() {}
}

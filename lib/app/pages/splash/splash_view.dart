import 'package:coupon_app/app/pages/splash/splash_controller.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SplashPage extends View {
  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ViewState<SplashPage, SplashController> {
  _SplashPageState() : super(SplashController());

  @override
  Widget get view => Scaffold(
        key: globalKey,
        body: _body,
      );

  get _body => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: SizedBox(width: 240, child: Image.asset(Resources.logo)),
        ),
      );
}

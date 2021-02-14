import 'package:coupon_app/app/pages/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class SplashController extends Controller{


  @override
  void initListeners() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      home();
    });
  }

  home(){
    Navigator.of(getContext()).pushReplacementNamed(Pages.main);
  }

}
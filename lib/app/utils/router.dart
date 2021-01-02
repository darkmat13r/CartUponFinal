
import 'package:coupon_app/app/main/main_view.dart';
import 'package:coupon_app/app/pages/home/home_view.dart';
import 'package:coupon_app/app/pages/product/product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:coupon_app/app/pages/login/login_view.dart';
import 'package:coupon_app/app/pages/pages.dart';

class AppRouter{
  final RouteObserver<PageRoute> routeObserver;
  AppRouter() : routeObserver  = RouteObserver<PageRoute>();

  Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Pages.login :
        return _buildRoute(settings, LoginPage());
      case Pages.home :
        return _buildRoute(settings, HomePage());
      case Pages.product :
        return _buildRoute(settings, ProductPage());
      case Pages.main :
        return _buildRoute(settings, MainPage());
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder){
    return new MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder
    );
  }
}
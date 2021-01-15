
import 'package:coupon_app/app/pages/home/home_view.dart';
import 'package:coupon_app/app/pages/main/main_view.dart';
import 'package:coupon_app/app/pages/order/order_view.dart';
import 'package:coupon_app/app/pages/orders/orders_view.dart';
import 'package:coupon_app/app/pages/product/product_view.dart';
import 'package:coupon_app/app/pages/profile/profile_view.dart';
import 'package:coupon_app/app/pages/reviews/create/create_review_view.dart';
import 'package:coupon_app/app/pages/reviews/reviews_view.dart';
import 'package:coupon_app/app/pages/search/search_view.dart';
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
      case Pages.profile :
        return _buildRoute(settings, ProfilePage());
      case Pages.orders :
        return _buildRoute(settings, OrdersPage());
      case Pages.order :
        return _buildRoute(settings, OrderPage());
      case Pages.reviews :
        return _buildRoute(settings, ReviewsPage());
      case Pages.createReview :
        return _buildRoute(settings, CreateReviewPage());
      case Pages.search :
        return _buildRoute(settings, SearchPage());
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder){
    return new MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder
    );
  }
}
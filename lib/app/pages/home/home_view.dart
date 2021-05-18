
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupon_app/app/components/product_item.dart';
import 'package:coupon_app/app/components/rating.dart';
import 'package:coupon_app/app/components/search_app_bar.dart';
import 'package:coupon_app/app/pages/home/home_controller.dart';
import 'package:coupon_app/app/pages/home/products/products_view.dart';
import 'package:coupon_app/app/pages/login/login_view.dart';
import 'package:coupon_app/app/pages/home/listing/mail_listing_view.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends View {
  @override
  State<StatefulWidget> createState() => HomePageView();
}

class HomePageView extends ViewState<HomePage, HomeController> {
  HomePageView() : super(HomeController());

  @override
  Widget get view => Scaffold(key: globalKey, body: _body);

  Widget get _appBar => SearchAppBar();

  final _tabs = [
    MainListingPage(),
    ProductsPage("0"),
    ProductsPage("1"),
  ];
  final _tabsText = [
    LocaleKeys.tabHome.tr(),

    LocaleKeys.tabCoupons.tr(),
    LocaleKeys.tabProducts.tr(),
  ];
  Widget get _body => DefaultTabController(length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primary,
          automaticallyImplyLeading: false,
          title: TabBar(
            indicatorColor: AppColors.accent,
            isScrollable: true,
            tabs: [
              for (final tab in _tabsText) Tab(text: tab),
            ],
          ),
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ));
}
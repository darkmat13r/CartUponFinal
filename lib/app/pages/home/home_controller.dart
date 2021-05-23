import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/home/home_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomeController extends BaseController{

  HomePresenter _homePresenter;
  HomeController(authRepo)  : _homePresenter = HomePresenter(authRepo){

  }

  @override
  void onResumed() {

    super.onResumed();
  }
  @override
  void initListeners() {
    initBaseListeners(_homePresenter);
  }


  void goToProductDetails(){
    Navigator.of(getContext()).pushNamed('/product');
  }
}
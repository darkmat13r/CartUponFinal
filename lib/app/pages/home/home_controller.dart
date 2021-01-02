import 'package:coupon_app/app/pages/home/home_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomeController extends Controller{

  HomePresenter _homePresenter;
  HomeController()  : _homePresenter = HomePresenter(){

  }

  @override
  void initListeners() {
  }

  void goToProductDetails(){
    Navigator.of(getContext()).pushNamed('/product');
  }
}
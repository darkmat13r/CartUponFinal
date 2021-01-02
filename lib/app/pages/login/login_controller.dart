import 'package:coupon_app/app/pages/login/login_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:coupon_app/app/pages/login/login_presenter.dart';
import 'package:coupon_app/domain/repositories/local_repository.dart';

class LoginController extends Controller{

  LoginPresenter _homePresenter;

  LoginController() : _homePresenter = LoginPresenter(){

  }

  @override
  void initListeners() {

  }

  void goToHome(){
    Navigator.of(getContext()).pushNamed('/main');
  }

  @override
  void dispose() {
    _homePresenter.dispose();
  }

}
import 'package:coupon_app/app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class WelcomeController extends Controller{
  @override
  void initListeners() {
  }

  void joinNow() {

  }

  void skip(){
    Navigator.of(getContext()).pushNamed(Pages.home);
  }

  void login() {
    Navigator.of(getContext()).pushNamed(Pages.login);
  }
  void register() {
    Navigator.of(getContext()).pushNamed(Pages.register);
  }

  void back() {
    Navigator.of(getContext()).pop();
  }
}
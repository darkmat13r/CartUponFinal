import 'package:coupon_app/app/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class RegisterController extends Controller{
  @override
  void initListeners() {
  }

  void goToHome() {
    Navigator.of(getContext()).pushReplacementNamed(Pages.main);
  }

  void login(){
    Navigator.pop(getContext());
  }
}
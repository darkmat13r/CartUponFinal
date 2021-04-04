import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MainController extends Controller{
  bool isLoggedIn = false;

  @override
  void initListeners() {
  }

  void fetchProfile() {
    SessionHelper().getCurrentUser().then((value){
      isLoggedIn = value != null;
      refreshUI();
      if(!isLoggedIn){
        login();
      }
    }).onError((error, stackTrace){
      if(!isLoggedIn){
        login();
      }
    });
  }
  void login() {
    Navigator.of(getContext()).pushNamed(Pages.welcome);
  }

}
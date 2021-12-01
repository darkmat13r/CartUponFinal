import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/main/main_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/payment/payment_view.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:pushwoosh/pushwoosh.dart';

class MainController extends BaseController {
  bool isLoggedIn = false;
  int selectedIndex = 0;

  MainPresenter _presenter;
  GlobalKey<ScaffoldState> _drawerKey;

  MainController(authRepo) : _presenter = MainPresenter(authRepo) {

  }

  @override
  void initListeners() {
    initBaseListeners(_presenter);
  }

  void checkProfile() {
    isLoggedIn = currentUser != null;
    if (currentUser == null) {
      login();
    }
  }



  onResumed() {
    super.onResumed();
  }

  BuildContext _currentContext;

  onAuthComplete() {
    super.onAuthComplete();
  }

  setKey(drawerKey) {
    if (_drawerKey == null) {
      _drawerKey = drawerKey;
      Future.delayed(const Duration(minutes: 10), () {
        showLoginDialog();
      });
    }
  }

  startSearch(GlobalKey key, String query) {
    AppRouter().querySearch(key.currentContext, query);
  }

  Future<void> login() async {
    await Navigator.of(getContext()).pushNamed(Pages.welcome);
    _presenter.getUser();
  }
  openUrl(context, String url) {

  }

  Future<void> showLoginDialog() async {
    int days = await SessionHelper().lastShownPopup();
    bool isPopupShown = await SessionHelper().isPopupShown();
    if (isPopupShown && days < 7) {
      return;
    }
    if (currentUser == null && _currentContext == null && _drawerKey != null) {
      SessionHelper().updateLastShownPopup();
      SessionHelper().setShownPopup();
      showLoginPopup(_drawerKey.currentContext, onCreate: (BuildContext context){
        _currentContext = context;
      }, onGuestSelected: (BuildContext context){

      }, onLoginSelected: (BuildContext context){
        Navigator.of(_drawerKey.currentContext)
            .pushNamed(Pages.login);
      }, onRegisterSelected: (BuildContext context){
        Navigator.of(_drawerKey.currentContext).pushNamed(Pages.requestOtp);
      });

    }
  }
}

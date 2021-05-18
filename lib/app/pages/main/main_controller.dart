import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/main/main_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class MainController extends BaseController {
  bool isLoggedIn = false;
  int selectedIndex = 0;

  MainPresenter _presenter;


  MainController(authRepo) : _presenter = MainPresenter(authRepo);

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

  onAuthComplete(){
      super.onAuthComplete();
  }

  startSearch(GlobalKey  key, String query){
    AppRouter().querySearch(key.currentContext, query);
  }

  Future<void> login() async {
    await Navigator.of(getContext()).pushNamed(Pages.welcome);
    _presenter.getUser();
  }
}

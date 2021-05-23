import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/account/account_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/usercases/auth/logout_usecase.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AccountController extends BaseController {

  AccountPresenter _presenter;

  Function onLogout;

  AccountController(this.onLogout, AuthenticationRepository authRepo)
      : _presenter = AccountPresenter(authRepo);

  @override
  void initListeners() {
    initBaseListeners(_presenter);
  }
  onAuthComplete(){
    refreshUI();
  }

  login() {
    Navigator.of(getContext()).pushNamed(Pages.welcome);
  }

  @override
  onLoggedOut() {
    if(onLogout != null){
      onLogout();
    }
    return super.onLoggedOut();
  }
  void goToPage(page) {
    if (currentUser != null) {
      Navigator.of(getContext()).pushNamed(page);
    } else {
      login();
    }
  }
}

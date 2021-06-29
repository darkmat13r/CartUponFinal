import 'package:coupon_app/app/pages/login/login_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class LoginController extends Controller{
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  bool isLoading =  false;
  LoginPresenter _loginPresenter;
  bool returnResult;
  LoginController(authRepo,{this.returnResult}) : _loginPresenter = LoginPresenter(authRepo) {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  @override
  void initListeners() {
    _loginPresenter.loginOnComplete = this._loginOnComplete;
    _loginPresenter.loginOnError = this._loginOnError;
  }

  void _loginOnComplete(Customer user) {
    dismissLoading();
    if (returnResult != null && returnResult){
      Navigator.pop(getContext(), user);
    }else{
      goToHome();
    }
  }

  void _loginOnError( e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: true);
    refreshUI();
  }

  void checkForm(Map<String, dynamic> params){
    dynamic formKey = params['formKey'];

    // Validate params
    assert(formKey is GlobalKey<FormState>);
    if (formKey.currentState.validate()) {
      login();
    } else {
      logger.shout('Login failed');
      showGenericSnackbar(getContext(), Strings.loginFormIncomplete,
          isError: true);
    }
  }

  /// Logs a [User] into the application
  void login() async {
    isLoading = true;
    refreshUI();
    _loginPresenter.login(
        email: emailTextController.text, password: passwordTextController.text);
  }

  void dismissLoading() {
    isLoading = false;
    refreshUI();
  }

  void register() {
    Navigator.of(getContext()).pop();
    Navigator.of(getContext()).pushNamed(Pages.requestOtp);
  }

  void forgotPassword() {
   Navigator.of(getContext()).pushNamed(Pages.forgotPassword);
  }

  void back() {
    Navigator.of(getContext()).pop();
  }

  void goToHome(){
    Navigator.of(getContext()).pushReplacementNamed(Pages.main);
  }

  @override
  void onDisposed() {
    _loginPresenter.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    super.onDisposed();
  }



}
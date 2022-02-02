import 'dart:async';

import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/auth_state_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/data/exceptions/authentication_exception.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

abstract class BaseController extends Controller {
  bool isLoading = false;
  bool isAuthUserLoading = false;

  Customer currentUser;
  AuthPresenter _authPresenter;
  StreamSubscription<Customer> streamSubscription;
  final authStream =  AuthStateStream();
  initBaseListeners(AuthPresenter authPresenter) {

    isAuthUserLoading = true;
    refreshUI();
    this._authPresenter = authPresenter;
    authPresenter.getCurrentUserOnNext = (token) => {this.currentUser = token};
    authPresenter.getCurrentUserOnError = (e) => {onAuthError(e)};
    authPresenter.getCurrentUserOnComplete = onAuthComplete;

    authPresenter.logoutOnNext = (res) => {dismissLoading()};
    authPresenter.logoutOnComplete = () {
      onLoggedOut();
    };
    authPresenter.logoutOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getContext(), e.messsage, isError: true);
    };
    streamSubscription = authStream.onAuthStateChanged().listen((event) {
      currentUser = event;
      onAuthComplete();
    });
  }

  fetchUser(){
    _authPresenter.getUser();
  }

  onAuthComplete() {
    isAuthUserLoading = false;
    refreshUI();
  }

  onAuthError(e) {
    // showGenericSnackbar(getContext(), e.message, isError : true);
    if(e is APIException){
      Logger().e(e.statusCode);
      if (e.statusCode == 401 && _authPresenter != null) {
        _authPresenter.logout();
      }
    }

  }

  onLoggedOut() {
    currentUser = null;
    refreshUI();
    // Navigator.of(getContext()).pushNamed(Pages.welcome);
  }

  logout() {
    showGenericConfirmDialog(getContext(), null, LocaleKeys.confirmLogout.tr(),
        confirmText: LocaleKeys.logout.tr(), onConfirm: () {
      if (_authPresenter != null) {
        _authPresenter.logout();
      }
    });
  }

  showLoading() {
    isLoading = true;
    refreshUI();
  }

  dismissLoading() {
    isLoading = false;
    refreshUI();
  }

  handlerUnknownError(e) {
    print(e);
  }

  showProgressDialog() {
    showLoadingDialog(getContext());
  }

  dismissProgressDialog() {
    dismissDialog();
  }

  @override
  void onDisposed() {
    if(streamSubscription !=  null ){
      streamSubscription.cancel();
    }
    super.onDisposed();
  }

  bool isLocaleEnglish(){
    return  EasyLocalization.of(getContext()).currentLocale.languageCode == "en";
  }

  void startSearch(GlobalKey<State<StatefulWidget>> globalKey, String query) {
    AppRouter().querySearch(globalKey.currentContext, query);
  }
}

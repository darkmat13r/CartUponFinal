import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

abstract class BaseController extends Controller {
  bool isLoading = false;
  bool isAuthUserLoading = false;

  Token currentUser;
  AuthPresenter _authPresenter;

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
  }

  onAuthComplete() {
    isAuthUserLoading = false;
    refreshUI();
  }

  onAuthError(e) {
    // showGenericSnackbar(getContext(), e.message, isError : true);
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
}

import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/forgot_password/forgot_password_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ForgotPasswordController extends BaseController {
  TextEditingController emailTextController;
  ForgotPasswordPresenter _forgotPasswordPresenter;
  ForgotPasswordController(authRepo)
      : _forgotPasswordPresenter = ForgotPasswordPresenter(authRepo) {
    emailTextController = TextEditingController();
  }

  @override
  void initListeners() {
    _forgotPasswordPresenter.getRestLinkOnComplete = this._onResetLinkSent;
    _forgotPasswordPresenter.getRestLinkOnError = this._onResetLinkSentError;
  }

  void checkForm(Map<String, dynamic> params) {
    dynamic formKey = params['formKey'];

    // Validate params
    assert(formKey is GlobalKey<FormState>);
    if (formKey.currentState.validate()) {
      sentResetLink();
    } else {
      logger.shout('Login failed');
      showGenericSnackbar(getContext(), LocaleKeys.errorIncompleteForm.tr(),
          isError: true);
    }
  }

  void back() {
    Navigator.of(getContext()).pop();
  }

  void dismissLoading() {
    isLoading = false;
    //ProgressHUD.of(getContext()).dismiss();
  }

  void sentResetLink() {
    showLoading();
    _forgotPasswordPresenter.sendPasswordResetLink(emailTextController.text);
  }

  _onResetLinkSent() {
    dismissLoading();
    showGenericSnackbar(
        getContext(), LocaleKeys.passwordResetLinkSent.tr());
    Navigator.of(getContext()).pop();
  }

  _onResetLinkSentError(error) {
    dismissLoading();
    showGenericSnackbar(getContext(), error.message.toString(), isError: true);
  }
}

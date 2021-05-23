import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/account/change_password/change_password_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class ChangePasswordController extends BaseController {
  TextEditingController newPasswordController;
  TextEditingController confirmPasswordController;
  FocusNode newPasswordFocus= new FocusNode();
  FocusNode confirmPasswordFocus  = new FocusNode();
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  ChangePasswordPresenter _presenter;

  ChangePasswordController(AuthenticationRepository authenticationRepository)
      : _presenter = ChangePasswordPresenter(authenticationRepository) {
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();

  }

  @override
  void initListeners() {
    _presenter.updateProfileOnComplete = () {
      dismissLoading();
     showGenericConfirmDialog(getContext(), null, LocaleKeys.passwordChanged.tr(), onConfirm: (){
       Navigator.of(getContext()).pop();
     });
     // showGenericSnackbar(getContext(), LocaleKeys.passwordChanged.tr());
    };
    _presenter.updateProfileOnNext = (user) {
      this.currentUser = user;
      refreshUI();
    };
    _presenter.updateProfileOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getContext(), e.message, isError: true);
    };
    newPasswordFocus.addListener(() {
      if (!newPasswordFocus.hasFocus) {
        isPasswordHidden = true;
      }
      Logger().e("Focus Change ${newPasswordFocus.hasFocus}");
      refreshUI();
    });
    confirmPasswordFocus.addListener(() {
      if (!confirmPasswordFocus.hasFocus) {
        isConfirmPasswordHidden = true;
      }
      Logger().e("confirmPasswordFocus Change ${confirmPasswordFocus.hasFocus}");
      refreshUI();
    });
  }

  void update() {
    showLoading();
    _presenter.update(newPasswordController.text);
  }

  void checkForm(Map<String, dynamic> params) {
    dynamic formKey = params['formKey'];
    // Validate params
    assert(formKey is GlobalKey<FormState>);
    if (formKey.currentState.validate()) {
      update();
    } else {
      logger.shout('Registration failed');
    }
  }

  void save() {
    Navigator.of(getContext()).pop();
  }

  void toggleConfirmPassword() {
    isConfirmPasswordHidden = !isConfirmPasswordHidden;
    refreshUI();
  }

  void togglePassword() {
    isPasswordHidden = !isPasswordHidden;
    refreshUI();
  }
}

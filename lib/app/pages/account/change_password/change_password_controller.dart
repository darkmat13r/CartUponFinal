import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/account/change_password/change_password_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ChangePasswordController extends BaseController{
  TextEditingController newPasswordController;
  TextEditingController confirmPasswordController;
  ChangePasswordPresenter _presenter;
  ChangePasswordController(AuthenticationRepository authenticationRepository) : _presenter = ChangePasswordPresenter(authenticationRepository){
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }


  @override
  void initListeners() {
    _presenter.updateProfileOnComplete = (){
      dismissLoading();
      Navigator.of(getContext()).pop();
      showGenericSnackbar(getContext(), LocaleKeys.passwordChanged.tr());
    };
    _presenter.updateProfileOnNext = (user){
      this.currentUser = user;
      refreshUI();

    };
    _presenter.updateProfileOnError = (e){
      dismissLoading();
      showGenericSnackbar(getContext(), e.message, isError: true);
    };
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
}
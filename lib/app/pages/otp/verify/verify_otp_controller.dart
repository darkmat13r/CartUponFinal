import 'dart:async';

import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/otp/verify/verify_otp_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/domain/repositories/verification_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpController extends BaseController {
  final String countryCode;
  final String mobileNumber;

  final VerifyOtpPresenter _presenter;

  TextEditingController otpController;
  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  bool returnResult;

  VerifyOtpController(this.countryCode, this.mobileNumber,
      VerificationRepository verificationRepository,
      {this.returnResult})
      : _presenter = VerifyOtpPresenter(verificationRepository) {
    errorController = StreamController<ErrorAnimationType>();
    otpController = TextEditingController();
  }

  @override
  void initListeners() {
    //showProgressDialog();
    Logger().e("Return result ${returnResult}");
    _presenter.requestOtp(mobileNumber: mobileNumber, countryCode: countryCode);
    initRequestOtpListeners();
    initVerifyOtpListeners();
  }

  String getSelectedMobileNumber() {
    return "${countryCode}-${mobileNumber}";
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    errorController.close();
    super.onDisposed();
  }

  void initRequestOtpListeners() {
    _presenter.requestOtpOnNext = (response) {};
    _presenter.requestOtpOnError = (error) {
      Navigator.of(getContext()).pop();
      showGenericSnackbar(getContext(), error.message, isError: true);
      dismissProgressDialog();
    };
    _presenter.requestOtpOnComplete = () {
      showGenericSnackbar(getContext(), LocaleKeys.otpSent.tr());
      dismissProgressDialog();
    };
  }

  void initVerifyOtpListeners() {
    _presenter.verifyOtpOnNext = (response) {};
    _presenter.verifyOtpOnError = (error) {
      showGenericSnackbar(getContext(), error.message, isError: true);
      dismissLoading();
    };
    _presenter.verifyOtpOnComplete = () async {
      if (returnResult != null && returnResult) {
        Navigator.pop(getContext(),
            {'country_code': countryCode, 'mobile': mobileNumber});
      } else {
        var result = await AppRouter().signup(
            getContext(), countryCode, mobileNumber,
            returnResult: returnResult);
        if (returnResult != null && returnResult) {
          Navigator.pop(getContext(), result);
        }
      }
      dismissLoading();
    };
  }

  void checkForm(Map<String, Object> params) {
    dynamic formKey = params['formKey'];
    // Validate params
    assert(formKey is GlobalKey<FormState>);
    if (formKey.currentState.validate()) {
      verifyOtp();
    } else {
      hasError = true;
      errorController.add(ErrorAnimationType.shake);
      refreshUI();
    }
  }

  void verifyOtp() {
    showLoading();
    _presenter.verifyOtp(
        mobileNumber: mobileNumber,
        countryCode: countryCode,
        text: otpController.text);
  }

  void resendOtp() {
    showProgressDialog();
    _presenter.requestOtp(mobileNumber: mobileNumber, countryCode: countryCode);
  }
}

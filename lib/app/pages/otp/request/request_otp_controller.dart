import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/otp/request/request_otp_presenter.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/repositories/verification_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class RequestOtpController extends BaseController {
  TextEditingController mobileNumberController;
  Country selectedCountry;
  List<Country> countries;
  final RequestOtpPresenter _presenter;
  bool returnResult;

  RequestOtpController(  {this.returnResult})
      : _presenter = RequestOtpPresenter() {
    mobileNumberController = TextEditingController();
    getCachedCountry();
    getCachedCountries();
  }

  @override
  void initListeners() {

  }

  void getCachedCountry() async {
    selectedCountry = Config().selectedCountry;
    refreshUI();
  }

  void getCachedCountries() async {
    countries = await SessionHelper().cachedCounties();
    refreshUI();
  }

  void checkForm(Map<String, dynamic> params) {
    dynamic formKey = params['formKey'];
    // Validate params
    assert(formKey is GlobalKey<FormState>);

    if (formKey.currentState.validate()) {
      if (selectedCountry == null) {
        showGenericSnackbar(
            getContext(), LocaleKeys.errorCountryCodeRequired.tr(),
            isError: true);
        return;
      }
      requestOtp();
    } else {
      showGenericSnackbar(getContext(), Strings.registrationFormIncomplete,
          isError: true);
    }
  }

  void requestOtp() async{
    dynamic result = await  AppRouter().verifyOtp(getContext(), selectedCountry.dial_code, mobileNumberController.text, returnResult  : returnResult);
    if (returnResult != null && returnResult){
      Navigator.pop(getContext(), result);
    }

  }

  void setSelectedCountry(Country countri) {
    selectedCountry = countri;
    refreshUI();
  }

  String getSelectedMobileNumber() {
    return "${selectedCountry.dial_code.replaceAll("+", "")}${mobileNumberController.text}";
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

}
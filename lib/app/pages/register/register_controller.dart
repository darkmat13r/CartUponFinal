import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/register/register_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/usercases/auth/register_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class RegisterController extends BaseController {
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController mobileNumberController;
  TextEditingController dobController;
  DateTime dob;
  String countryCode;

  RegisterPresenter _presenter;

  Logger _logger;

  RegisterController(AuthenticationRepository authRepo)
      : _presenter = RegisterPresenter(authRepo) {
    _logger = Logger("RegisterController");
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    mobileNumberController = TextEditingController();
    dobController = TextEditingController();
  }

  @override
  void initListeners() {
    _presenter.registerOnComplete = () {
      dismissLoading();
    };

    _presenter.registerOnNext = (user) {
      goToHome();
    };
    _presenter.registerOnError = (e) {
      _logger.shout(e);
      showGenericSnackbar(getContext(), e.message);
    };
  }

  void checkForm(Map<String, dynamic> params) {
    dynamic formKey = params['formKey'];
    // Validate params
    assert(formKey is GlobalKey<FormState>);
    if (formKey.currentState.validate()) {
      if (dob == null) {
        showGenericDialog(
            getContext(), "Alert", LocaleKeys.errorDateOfBirthRequired.tr());
        return;
      }
      register();
    } else {
      logger.shout('Registration failed');
      showGenericSnackbar(getContext(), Strings.registrationFormIncomplete,
          isError: true);
    }
  }

  void register() {
    showLoading();
    _presenter.register(RegisterParams(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        countryCode: countryCode,
        mobileNo: mobileNumberController.text,
        dateOfBirth: DateFormat('yyyy-MM-dd').format(dob),
        password: passwordController.text));
  }

  void goToHome() {
    Navigator.of(getContext()).pushReplacementNamed(Pages.main);
  }

  void login() {
    Navigator.pop(getContext());
  }

  void setDob(DateTime picked) {
    this.dob = picked;
    dobController.text = DateFormat.yMMMMd('en_US').format(dob);
    refreshUI();
  }
}

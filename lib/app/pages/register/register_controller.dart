import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/register/register_presenter.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/Nationality.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/nationality_repository.dart';
import 'package:coupon_app/domain/usercases/auth/register_usecase.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class RegisterController extends BaseController {
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController mobileNumberController;
  TextEditingController dobController;
  final String countryCode;
  final String mobileNumber;
  DateTime dob;
  int title;
  int gender;
  Nationality nationality;
  List<Nationality> nationalities;

  Country selectedCountry;
  RegisterPresenter _presenter;

  Logger _logger;
  List<Country> countries;

  RegisterController(
      AuthenticationRepository authRepo,
      NationalityRepository nationalityRepository,
      this.countryCode,
      this.mobileNumber)
      : _presenter = RegisterPresenter(authRepo, nationalityRepository) {
    _logger = Logger();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    mobileNumberController = TextEditingController();
    dobController = TextEditingController();
    getCachedCountry();
    getCachedCountries();
    mobileNumberController.text = getSelectedMobileNumber();
    if(countryCode == null && mobileNumber == null){
      Navigator.of(getContext()).pop();
      Navigator.of(getContext()).pushNamed(Pages.requestOtp);
    }
  }

  @override
  void onResumed() {
    super.onResumed();
  }

  String getSelectedMobileNumber() {
    return "${countryCode}${mobileNumber}";
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
      _logger.e(e);
      showGenericSnackbar(getContext(), e.message, isError: true);
    };

    initNationalityListeners();
  }

  Future<List<Nationality>> getFilterNationality(String query) {
    return Future.value(nationalities
        .where((element) =>
            element.country_name.toLowerCase().contains(query.toLowerCase()))
        .toList());
  }

  void checkForm(Map<String, dynamic> params) {
    dynamic formKey = params['formKey'];
    // Validate params
    assert(formKey is GlobalKey<FormState>);
    if (formKey.currentState.validate()) {
      if (dob == null) {
        showGenericDialog(getContext(), LocaleKeys.alert.tr(),
            LocaleKeys.errorDateOfBirthRequired.tr());
        return;
      }
      if (nationality == null) {
        showGenericDialog(getContext(), LocaleKeys.alert.tr(),
            LocaleKeys.errorSelectNationality.tr());
        return;
      }
      /*if (gender == null) {
        showGenericDialog(getContext(), LocaleKeys.alert.tr(),
            LocaleKeys.errorSelectGender.tr());
        return;
      }*/
      if (title == null) {
        showGenericDialog(getContext(), LocaleKeys.alert.tr(),
            LocaleKeys.errorSelectTitle.tr());
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
        countryCode:
            countryCode,
        nationality: nationality.id,
        gender: gender,
        title: title,
        mobileNo: mobileNumber,
        dateOfBirth: DateFormat('yyyy-MM-dd').format(dob),
        password: passwordController.text));
  }

  void goToHome() {
    Navigator.of(getContext()).pushReplacementNamed(Pages.main);
    //Navigator.of(getContext()).pop();
  }

  void login() {
    Navigator.pop(getContext());
  }

  void setDob(DateTime picked) {
    this.dob = picked;
    dobController.text = DateFormat.yMMMMd('en_US').format(dob);
    refreshUI();
  }

  void initNationalityListeners() {
    _presenter.getNationalitiesOnComplete = () {
      dismissProgressDialog();
    };
    _presenter.getNationalitiesOnError = (e) {
      dismissProgressDialog();
      showGenericSnackbar(getContext(), e.message, isError: true);
    };
    _presenter.getNationalitiesOnNext = (response) {
      this.nationalities = response;
      refreshUI();
    };
  }

  setNationality(Nationality data) {
    this.nationality = data;
    refreshUI();
  }

  setTitle(int value) {
    this.title = value;
    refreshUI();
  }

  setGender(int gender) {
    this.gender = gender;
    refreshUI();
  }

  void getCachedCountry() async {
    selectedCountry = Config().selectedCountry;
    refreshUI();
  }

  void getCachedCountries() async {
    countries = await SessionHelper().cachedCounties();

    refreshUI();
  }

  void setSelectedCountry(Country countri) {
    selectedCountry = countri;
    refreshUI();
  }
}

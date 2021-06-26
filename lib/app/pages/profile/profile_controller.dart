import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/profile/profile_presenter.dart';
import 'package:coupon_app/app/pages/register/register_presenter.dart';
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/Nationality.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/nationality_repository.dart';
import 'package:coupon_app/domain/usercases/auth/register_usecase.dart';
import 'package:coupon_app/domain/usercases/auth/update_profile_usecase.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class ProfileController extends BaseController {
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController mobileNumberController;
  TextEditingController dobController;
  DateTime dob;
  String countryCode;
  int title;
  int gender;
  Nationality nationality;
  List<Nationality> nationalities;
  Country selectedCountry;
  ProfilePresenter _presenter;
  List<Country> countries;
  ProfileController(AuthenticationRepository authRepo,
      NationalityRepository nationalityRepository)
      : _presenter = ProfilePresenter(authRepo, nationalityRepository) {
    _logger = Logger();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileNumberController = TextEditingController();
    dobController = TextEditingController();
    getCachedCountry();
    getCachedCountries();
  }

  Logger _logger;

  void getCachedCountry() async {
    selectedCountry = Config().selectedCountry;
    refreshUI();
  }

  @override
  void initListeners() {
    initBaseListeners(_presenter);
    _presenter.updateProfileOnComplete = () {
      dismissLoading();
      // Navigator.of(getContext()).pop();
      showGenericConfirmDialog(
          getContext(), null, LocaleKeys.profileUpdated.tr(), onConfirm: () {
        Navigator.of(getContext()).pop();
      });
      // showGenericSnackbar(getContext(), LocaleKeys.profileUpdated.tr());
    };
    _presenter.updateProfileOnNext = (user) {
      this.currentUser = user;
      refreshUI();
    };
    _presenter.updateProfileOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getContext(), e.message, isError: true);
    };
    initNationalityListeners();
  }

  @override
  onAuthComplete() {
    firstNameController.text = currentUser.user.first_name;
    lastNameController.text = currentUser.user.last_name;
    emailController.text = currentUser.user.email;
    _logger.e( currentUser.user.email);
    gender = currentUser.gender;
    title = currentUser.title;
    mobileNumberController.text = currentUser.user.username;
    dob = DateFormat("yyyy-MM-dd").parse(currentUser.date_of_birth);
    setDob(dob);
    updateNationality();
    updateCountryCode();
    super.onAuthComplete();
  }

  updateCountryCode(){
    if(currentUser != null){
      try{
        _logger.e("Countries ${countries}");
        _logger.e("currentUser.country_code ${currentUser.country_code}");
        selectedCountry = countries.firstWhere((element) => element.dial_code.replaceAll("+", "") == currentUser.country_code.replaceAll("+", ""));
        refreshUI();
      }catch(e){
        _logger.e(e);
      }
    }
  }

  void update() {
    showLoading();
    _presenter.update(UpdateProfileParams(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        countryCode: selectedCountry.dial_code,
        nationality: nationality.id,
        gender: gender,
        title: title,
        mobileNo: mobileNumberController.text,
        dateOfBirth: DateFormat('yyyy-MM-dd').format(dob)));
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
      if (nationality == null) {
        showGenericDialog(getContext(), LocaleKeys.alert.tr(),
            LocaleKeys.errorSelectNationality.tr());
        return;
      }
     /* if (gender == null) {
        showGenericDialog(getContext(), LocaleKeys.alert.tr(),
            LocaleKeys.errorSelectGender.tr());
        return;
      }*/
      if (title == null) {
        showGenericDialog(getContext(), LocaleKeys.alert.tr(),
            LocaleKeys.errorSelectTitle.tr());
        return;
      }
      update();
    } else {
      logger.shout('Registration failed');
    }
  }

  void setDob(DateTime picked) {
    this.dob = picked;
    dobController.text = DateFormat.yMMMMd('en_US').format(dob);
    refreshUI();
  }

  changePassword() {
    Navigator.of(getContext()).pushNamed(Pages.changePassword);
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
      updateNationality();
      refreshUI();
    };
  }

  Future<List<Nationality>> getFilterNationality(String query) {
    return Future.value(nationalities
        .where((element) =>
            element.country_name.toLowerCase().contains(query.toLowerCase()))
        .toList());
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

  Future<bool> onWillPop() {
    var areChangesMade =
        currentUser.user.first_name != firstNameController.text ||
            currentUser.user.last_name != lastNameController.text ||
            currentUser.mobile_no != mobileNumberController.text ||
            currentUser.country_code.replaceAll("+", "") != selectedCountry.dial_code.replaceAll("+", "") ||
            currentUser.nationality != nationality.id ||
            currentUser.gender != gender ||
            currentUser.title != title ||
            currentUser.date_of_birth != DateFormat('yyyy-MM-dd').format(dob);
    if (areChangesMade) {
      showGenericConfirmDialog(getContext(), LocaleKeys.discardChanges.tr(),
          LocaleKeys.confirmDiscardChanges.tr(), onConfirm: () {
        Navigator.of(getContext()).pop();
      });
    } else {
      Navigator.of(getContext()).pop();
    }
  }

  void updateNationality() {
    if (nationalities != null &&
        nationalities.isNotEmpty &&
        currentUser != null) {
      try {
        this.nationality = this
            .nationalities
            .firstWhere((element) => element.id == currentUser.nationality);
      } catch (e) {}
      refreshUI();
    }
  }
  void getCachedCountries() async{
    countries = await SessionHelper().cachedCounties();
    refreshUI();
  }
  void setSelectedCountry(Country countri) {
    selectedCountry = countri;
    refreshUI();
  }
}

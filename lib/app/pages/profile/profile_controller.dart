import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/profile/profile_presenter.dart';
import 'package:coupon_app/app/pages/register/register_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/usercases/auth/register_usecase.dart';
import 'package:coupon_app/domain/usercases/auth/update_profile_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class ProfileController extends BaseController {
  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController emailController;
  TextEditingController mobileNumberController;
  TextEditingController dobController;
  DateTime dob;
  String countryCode;

  ProfilePresenter _presenter;

  ProfileController(AuthenticationRepository authRepo)
      : _presenter = ProfilePresenter(authRepo) {
    _logger = Logger("ProfileController");
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileNumberController = TextEditingController();
    dobController = TextEditingController();
  }

  Logger _logger;

  @override
  void initListeners() {
    initBaseListeners(_presenter);
    _presenter.updateProfileOnComplete = (){
      dismissLoading();
      Navigator.of(getContext()).pop();
      showGenericSnackbar(getContext(), LocaleKeys.profileUpdated.tr());
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

  @override
  onAuthComplete() {
    firstNameController.text = currentUser.user.first_name;
    lastNameController.text  = currentUser.user.last_name;
    emailController.text  = currentUser.user.username;
    mobileNumberController.text  = currentUser.mobile_no;
    dob  = DateFormat("yyyy-MM-dd").parse(currentUser.date_of_birth);
    setDob(dob);
    super.onAuthComplete();

  }

  void update() {
    showLoading();
    _presenter.update(UpdateProfileParams(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        countryCode: countryCode,
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
}

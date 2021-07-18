import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/welcome/welcome_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class WelcomeController extends Controller {
  final facebookLogin = FacebookLogin();

  final WelcomePresenter _presenter;


  WelcomeController(AuthenticationRepository _authRepo)
      : _presenter = WelcomePresenter(_authRepo);

  @override
  void initListeners() {
    _presenter.facebookLoginComplete = _loginOnComplete;
    _presenter.googleLoginComplete = _loginOnComplete;
    _presenter.facebookLoginError = _loginOnError;
    _presenter.googleLoginError = _loginOnError;
  }

  void _loginOnComplete(Customer user) {
    goToHome();
  }

  void _loginOnError(e) {
    showGenericSnackbar(getContext(), e.message, isError: true);
    refreshUI();
  }

  void goToHome() {
    Navigator.of(getContext()).pushReplacementNamed(Pages.main);
  }

  void skip() {
    Navigator.of(getContext()).pushNamed(Pages.main);
  }

  void login() {
    Navigator.of(getContext()).pop();
    Navigator.of(getContext()).pushNamed(Pages.login);
  }

  void register() {
    Navigator.of(getContext()).pop();
    Navigator.of(getContext()).pushNamed(Pages.requestOtp);
  }

  void back() {
    Navigator.of(getContext()).pop();
  }

  loginWithFacebook() async {
    final result = await facebookLogin.logIn(['email','public_profile']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        Logger().e("FB Token ${result.accessToken.token}");
        _presenter.facebookLogin(accessToken: result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        showGenericSnackbar(
            getContext(), LocaleKeys.loginCancelled.tr(), isError: true);
        break;
      case FacebookLoginStatus.error:
        showGenericSnackbar(getContext(), result.errorMessage, isError: true);
        print(result.errorMessage);
        break;
    }
  }

  loginWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try {
      final user = await _googleSignIn.signIn();
      if(user != null){
        final GoogleSignInAuthentication googleAuth = await user.authentication;
        _presenter.googleLogin(accessToken: googleAuth.accessToken);
      }
    } catch (error) {
      showGenericSnackbar(getContext(), error.message, isError: true);
      print(error.message);
    }
  }
}
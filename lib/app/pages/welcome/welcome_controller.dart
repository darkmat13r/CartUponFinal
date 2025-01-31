import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/welcome/welcome_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
class WelcomeController extends Controller {

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
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
    final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken;
      _presenter.facebookLogin(accessToken: result.accessToken.token);
      analytics.logSignUp(
        signUpMethod: 'Facebook',
      );
    } else {
      print(result.status);
      print(result.message);
      showGenericSnackbar(
          getContext(), result.message, isError: true);
    }
   /* final result = await facebookLogin.logIn(['email','public_profile']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        Logger().e("FB Token ${result.accessToken.token}");
        _presenter.facebookLogin(accessToken: result.accessToken.token);
        analytics.logSignUp(
          signUpMethod: 'Facebook',
        );
        break;
      case FacebookLoginStatus.cancelledByUser:
        showGenericSnackbar(
            getContext(), LocaleKeys.loginCancelled.tr(), isError: true);
        break;
      case FacebookLoginStatus.error:
        showGenericSnackbar(getContext(), result.errorMessage, isError: true);
        print(result.errorMessage);
        break;
    }*/
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
        analytics.logSignUp(
          signUpMethod: 'Google',
        );
      }
    } catch (error) {
      showGenericSnackbar(getContext(), error.message, isError: true);
      print(error.message);
    }
  }
}
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class WelcomeController extends Controller{
  final facebookLogin = FacebookLogin();

  @override
  void initListeners() {
  }

  void joinNow() {

  }

  void skip(){
    Navigator.of(getContext()).pushNamed(Pages.home);
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

  loginWithFacebook() async{
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        Logger().e("FB TOken ${result.accessToken.token}");
        break;
      case FacebookLoginStatus.cancelledByUser:
        showGenericSnackbar(getContext(), LocaleKeys.loginCancelled.tr(), isError: true);
        break;
      case FacebookLoginStatus.error:
        showGenericSnackbar(getContext(), result.errorMessage, isError: true);
        break;
    }
  }
  loginWithGoogle() async{
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try {
      await _googleSignIn.signIn();

    } catch (error) {
      showGenericSnackbar(getContext(), error.message, isError: true);
    }
  }
}
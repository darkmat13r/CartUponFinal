import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/usercases/auth/login_with_facebook_usecase.dart';
import 'package:coupon_app/domain/usercases/auth/login_with_google_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class WelcomePresenter extends Presenter{

  final LoginWithFacebookUsecase _fbLoginUseCase;
  final LoginWithGoogleUsecase _googleLoginUseCase;
  Function facebookLoginComplete;
  Function facebookLoginError;
  Function googleLoginComplete;
  Function googleLoginError;

  WelcomePresenter(AuthenticationRepository authenticationRepository) :
        _fbLoginUseCase = LoginWithFacebookUsecase(authenticationRepository),
        _googleLoginUseCase = LoginWithGoogleUsecase(authenticationRepository);

  void facebookLogin({@required String accessToken}){
    _fbLoginUseCase.execute(_LoginFacebookUseCaseObserver(this), FbLoginParams(accessToken: accessToken));
  }

  void googleLogin({@required String accessToken}){
    _googleLoginUseCase.execute(_LoginGoogleUseCaseObserver(this), GLoginParams(accessToken: accessToken));
  }

  @override
  void dispose() {
    _fbLoginUseCase.dispose();
    _googleLoginUseCase.dispose();
  }
}

class _LoginFacebookUseCaseObserver implements Observer<Customer>{
  WelcomePresenter _loginPresenter;

  _LoginFacebookUseCaseObserver(this._loginPresenter);

  @override
  void onComplete() {
    // TODO: implement onComplete
  }

  @override
  void onError(e) {
    if(_loginPresenter.facebookLoginError != null){
      _loginPresenter.facebookLoginError(e);
    }
  }

  @override
  void onNext(user) {
    _loginPresenter.facebookLoginComplete(user);
  }

}

class _LoginGoogleUseCaseObserver implements Observer<Customer>{
  WelcomePresenter _loginPresenter;

  _LoginGoogleUseCaseObserver(this._loginPresenter);

  @override
  void onComplete() {
    // TODO: implement onComplete
  }

  @override
  void onError(e) {
    if(_loginPresenter.googleLoginError != null){
      _loginPresenter.googleLoginError(e);
    }
  }

  @override
  void onNext(user) {
    _loginPresenter.googleLoginComplete(user);
  }

}

import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/usercases/auth/get_current_user_usecase.dart';
import 'package:coupon_app/domain/usercases/auth/get_user_profile_usecase.dart';
import 'package:coupon_app/domain/usercases/auth/logout_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AuthPresenter extends Presenter {
  GetCurrentUserUseCase _getCurrentUserUseCase;
  GetUserProfileUseCase _getUserUseCase;
  LogoutUseCase _logoutUseCase;

  Function getCurrentUserOnComplete;
  Function getCurrentUserOnError;
  Function getCurrentUserOnNext;

  Function logoutOnComplete;
  Function logoutOnError;
  Function logoutOnNext;

  AuthPresenter(AuthenticationRepository authRepo)
      : _getCurrentUserUseCase = GetCurrentUserUseCase(authRepo),
        _getUserUseCase = GetUserProfileUseCase(authRepo),
        _logoutUseCase = LogoutUseCase(authRepo) {
    getUser();
    _getUserUseCase.execute(_GetCurrentUserObserver(this));
  }

  getUser() {
    _getCurrentUserUseCase.execute(_GetCurrentUserObserver(this));
  }

  logout() {
    _logoutUseCase.execute(_LogoutObserver(this));
  }

  @override
  void dispose() {
    _getCurrentUserUseCase.dispose();
  }
}

class _LogoutObserver extends Observer<void> {
  AuthPresenter _presenter;

  _LogoutObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.logoutOnComplete != null);
    _presenter.logoutOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.logoutOnError != null);
    _presenter.logoutOnError(e);
  }

  @override
  void onNext(void response) {
    assert(_presenter.logoutOnNext != null);
    _presenter.logoutOnNext(response);
  }
}

class _GetCurrentUserObserver extends Observer<Customer> {
  AuthPresenter _presenter;

  _GetCurrentUserObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getCurrentUserOnComplete != null);
    _presenter.getCurrentUserOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getCurrentUserOnError != null);
    _presenter.getCurrentUserOnError(e);
  }

  @override
  void onNext(Customer response) {
    assert(_presenter.getCurrentUserOnNext != null);
    _presenter.getCurrentUserOnNext(response);
  }
}


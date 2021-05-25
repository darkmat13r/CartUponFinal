import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/usercases/auth/change_password_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class ChangePasswordPresenter extends Presenter{
  ChangePasswordUseCase changePasswordUsecase;
  Function updateProfileOnComplete;
  Function updateProfileOnNext;
  Function updateProfileOnError;

  Logger _logger;
  ChangePasswordPresenter(AuthenticationRepository authRepo) : changePasswordUsecase = ChangePasswordUseCase(authRepo){
    _logger = Logger();
  }
  @override
  void dispose() {
    changePasswordUsecase.dispose();
  }

  void update(String currentPassword, String newPassword, String confirm) {
    changePasswordUsecase.execute(_UpdateProfileObserver(this), ChangePasswordParams(currentPassword, newPassword, confirm));
  }
}

class _UpdateProfileObserver extends Observer<void>{
  ChangePasswordPresenter _presenter;


  _UpdateProfileObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.updateProfileOnComplete != null);
    _presenter.updateProfileOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.updateProfileOnError  != null);
    _presenter.updateProfileOnError(e);
  }

  @override
  void onNext(void response) {
    assert(_presenter.updateProfileOnNext != null);
    _presenter.updateProfileOnNext(response);
  }

}
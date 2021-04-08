import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/usercases/auth/register_usecase.dart';
import 'package:coupon_app/domain/usercases/auth/update_profile_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class ProfilePresenter extends AuthPresenter{
  UpdateProfileUseCase updateProfileUseCase;
  Function updateProfileOnComplete;
  Function updateProfileOnNext;
  Function updateProfileOnError;
  Logger _logger;
  ProfilePresenter(AuthenticationRepository authRepo) : updateProfileUseCase = UpdateProfileUseCase(authRepo), super(authRepo){
    _logger = Logger("ProfilePresenter");
  }

  @override
  void dispose() {
    updateProfileUseCase.dispose();
  }

  void update(UpdateProfileParams params) {
    updateProfileUseCase.execute(_UpdateProfileObserver(this), params);
  }
}


class _UpdateProfileObserver extends Observer<Token>{
  ProfilePresenter _presenter;


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
  void onNext(Token response) {
    assert(_presenter.updateProfileOnNext != null);
    _presenter.updateProfileOnNext(response);
  }



}
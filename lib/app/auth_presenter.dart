import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/usercases/auth/get_current_user_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AuthPresenter extends Presenter{
  GetCurrentUserUseCase _getCurrentUserUseCase;

  Function getCurrentUserOnComplete;
  Function getCurrentUserOnError;
  Function getCurrentUserOnNext;


  AuthPresenter(AuthenticationRepository authRepo): _getCurrentUserUseCase = GetCurrentUserUseCase(authRepo){
    _getCurrentUserUseCase.execute(_GetCurrentUserObserver(this));
  }

  @override
  void dispose() {
    _getCurrentUserUseCase.dispose();
  }

}
class _GetCurrentUserObserver extends Observer<Token>{
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
  void onNext(Token response) {
    assert(_presenter.getCurrentUserOnNext != null);
    _presenter.getCurrentUserOnNext(response);
  }

}
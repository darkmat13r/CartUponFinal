import 'package:coupon_app/domain/usercases/auth/forgot_password_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ForgotPasswordPresenter extends Presenter{

  ForgotPasswordUseCase  _forgotPasswordUseCase;

  ForgotPasswordPresenter(authRepo){
    _forgotPasswordUseCase = ForgotPasswordUseCase(authRepo);

  }

  Function getRestLinkOnComplete;
  Function getRestLinkOnError;
  Function getRestLinkOnNext;

  void sendPasswordResetLink(String email){
    _forgotPasswordUseCase.execute(_ForgotPasswordObserver(this), ForgotPasswordUseCaseParams(email));
  }

  @override
  void dispose() {
    _forgotPasswordUseCase.dispose();
  }
}
class _ForgotPasswordObserver implements Observer<void>{
  ForgotPasswordPresenter _presenter;


  _ForgotPasswordObserver(this._presenter);

  @override
  void onComplete() {
    if(_presenter.getRestLinkOnComplete != null){
      _presenter.getRestLinkOnComplete();
    }
  }

  @override
  void onError(e) {
    if(_presenter.getRestLinkOnError != null){
      _presenter.getRestLinkOnError(e);
    }
  }

  @override
  void onNext(void response) {
  }
}
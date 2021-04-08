import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/usercases/auth/register_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class RegisterPresenter extends  Presenter{

  RegisterUseCase _registerUseCase;

  Function registerOnComplete;
  Function registerOnNext;
  Function registerOnError;
  Logger _logger;
  RegisterPresenter(AuthenticationRepository authRepo ) : _registerUseCase = RegisterUseCase(authRepo){
     _logger = Logger("RegisterPresenter");
  }


  register(RegisterParams params){
    _registerUseCase.execute(_RegisterObserver(this), params);
  }

  @override
  void dispose() {
    _registerUseCase.dispose();
  }
}


class _RegisterObserver extends Observer<Token>{

  RegisterPresenter _presenter;


  _RegisterObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.registerOnComplete != null);
    _presenter.registerOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.registerOnError != null);
    print("============>error");
    _presenter.registerOnError(e);
  }

  @override
  void onNext(Token response) {
    assert(_presenter.registerOnNext != null);
    _presenter.registerOnNext(response);
  }

}
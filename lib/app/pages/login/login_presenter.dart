import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/entities/user_entity.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/usercases/auth/login_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class LoginPresenter extends Presenter{

  AuthenticationRepository _authenticationRepository;
  LoginUseCase _loginUseCase;

  // Controller Callback functions
  Function loginOnComplete;
  Function loginOnError;

  LoginPresenter(this._authenticationRepository) {
    // Initialize the [UseCase] with the appropriate repository
    _loginUseCase = LoginUseCase(_authenticationRepository);
  }

  /// Login using the [email] and [password] provided
  void login({@required String email, @required String password}) {
    _loginUseCase.execute(_LoginUserCaseObserver(this), LoginUseCaseParams(email, password));
  }
  @override
  void dispose() {
    _loginUseCase.dispose();
  }
}

/// The [Observer] used to observe the `Observable` of the [LoginUseCase]
class _LoginUserCaseObserver implements Observer<Customer> {

  // The above presenter
  LoginPresenter _loginPresenter;

  _LoginUserCaseObserver(this._loginPresenter);

  /// implement if the `Observable` emits a value
  void onNext(user) {
    _loginPresenter.loginOnComplete(user);
  }

  /// Login is successfull, trigger event in [LoginController]
  void onComplete() {
    // any cleaning or preparation goes here


  }

  /// Login was unsuccessful, trigger event in [LoginController]
  void onError(e) {
    // any cleaning or preparation goes here
    if (_loginPresenter.loginOnError != null) {
      _loginPresenter.loginOnError(e);
    }
  }
}

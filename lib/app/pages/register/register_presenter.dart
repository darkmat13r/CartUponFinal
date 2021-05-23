import 'package:coupon_app/domain/entities/models/Nationality.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/nationality_repository.dart';
import 'package:coupon_app/domain/usercases/auth/get_nationality_usecase.dart';
import 'package:coupon_app/domain/usercases/auth/register_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class RegisterPresenter extends Presenter {
  RegisterUseCase _registerUseCase;
  GetNationalitiesUseCase _getNationalitiesUseCase;

  Function registerOnComplete;
  Function registerOnNext;
  Function registerOnError;

  Function getNationalitiesOnComplete;
  Function getNationalitiesOnNext;
  Function getNationalitiesOnError;

  Logger _logger;

  RegisterPresenter(AuthenticationRepository authRepo,
      NationalityRepository nationalityRepository)
      : _registerUseCase = RegisterUseCase(authRepo),
        _getNationalitiesUseCase = GetNationalitiesUseCase(nationalityRepository) {
    _logger = Logger("RegisterPresenter");
    fetchNationalities();
  }

  register(RegisterParams params) {
    _registerUseCase.execute(_RegisterObserver(this), params);
  }

  @override
  void dispose() {
    _registerUseCase.dispose();
  }

  void fetchNationalities() {
    _getNationalitiesUseCase.execute(_NationalityObserver(this));
  }
}

class _NationalityObserver extends Observer<List<Nationality>>{
  RegisterPresenter _presenter;

  _NationalityObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getNationalitiesOnComplete != null);
    _presenter.getNationalitiesOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getNationalitiesOnError != null);
    _presenter.getNationalitiesOnError(e);
  }

  @override
  void onNext(List<Nationality> response) {
    assert(_presenter.getNationalitiesOnNext != null);
    _presenter.getNationalitiesOnNext(response);
  }


}

class _RegisterObserver extends Observer<Token> {
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

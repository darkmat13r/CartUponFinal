import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/usercases/get_countries_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

 class SplashPresenter extends Presenter {
  final GetCountriesUseCase _getCountriesUseCase;

  Function getCountriesOnComplete;
  Function getCountriesOnNext;
  Function getCountriesOnError;

  SplashPresenter(CountryRepository _repository)
      : _getCountriesUseCase = GetCountriesUseCase(_repository) {
    _getCountriesUseCase.execute(_GetCountriesUseCase(this));
  }

  @override
  void dispose() {
    _getCountriesUseCase.dispose();
  }
}

class _GetCountriesUseCase extends Observer<List<Country>> {
  final SplashPresenter _presenter;

  _GetCountriesUseCase(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getCountriesOnComplete != null);
    _presenter.getCountriesOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getCountriesOnError != null);
    _presenter.getCountriesOnError(e);
  }

  @override
  void onNext(List<Country> response) {
    assert(_presenter.getCountriesOnNext != null);
    _presenter.getCountriesOnNext(response);
  }
}

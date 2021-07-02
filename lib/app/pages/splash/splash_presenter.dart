import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/ipdetect/IPDetectResponse.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/usercases/detech_country_usecase.dart';
import 'package:coupon_app/domain/usercases/get_countries_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

 class SplashPresenter extends Presenter {
  final GetCountriesUseCase _getCountriesUseCase;
  final DetectCountryUseCase _detectCountryUseCase;

  Function getCountriesOnComplete;
  Function getCountriesOnNext;
  Function getCountriesOnError;


  Function detectCountryOnComplete;
  Function detectCountryOnError;
  Function detectCountryOnNext;

  SplashPresenter(CountryRepository _repository)
      :_detectCountryUseCase = DetectCountryUseCase(_repository), _getCountriesUseCase = GetCountriesUseCase(_repository) {
    detectCountry();
  }


  detectCountry(){
    _detectCountryUseCase.execute(_DetectCountryObserver(this));
  }
  fetchCountries(){
    _getCountriesUseCase.execute(_GetCountriesUseCase(this));
  }

  @override
  void dispose() {
    _getCountriesUseCase.dispose();
  }
}
class _DetectCountryObserver extends Observer<IPDetectResponse> {
  final SplashPresenter _presenter;

  _DetectCountryObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.detectCountryOnComplete != null);
    _presenter.detectCountryOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.detectCountryOnError != null);
    _presenter.detectCountryOnError(e);
  }

  @override
  void onNext(IPDetectResponse response) {
    assert(_presenter.detectCountryOnNext != null);
    _presenter.detectCountryOnNext(response);
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

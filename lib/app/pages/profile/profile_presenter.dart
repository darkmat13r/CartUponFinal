import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/app/pages/splash/splash_presenter.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/Nationality.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/entities/models/ipdetect/IPDetectResponse.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/repositories/nationality_repository.dart';
import 'package:coupon_app/domain/usercases/auth/get_nationality_usecase.dart';
import 'package:coupon_app/domain/usercases/auth/register_usecase.dart';
import 'package:coupon_app/domain/usercases/auth/update_profile_usecase.dart';
import 'package:coupon_app/domain/usercases/detech_country_usecase.dart';
import 'package:coupon_app/domain/usercases/get_countries_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class ProfilePresenter extends AuthPresenter {
  UpdateProfileUseCase updateProfileUseCase;
  GetNationalitiesUseCase _getNationalitiesUseCase;

  final GetCountriesUseCase _getCountriesUseCase;
  final DetectCountryUseCase _detectCountryUseCase;

  Function updateProfileOnComplete;
  Function updateProfileOnNext;
  Function updateProfileOnError;

  Function getNationalitiesOnComplete;
  Function getNationalitiesOnNext;
  Function getNationalitiesOnError;

  Function getCountriesOnComplete;
  Function getCountriesOnNext;
  Function getCountriesOnError;

  Function detectCountryOnComplete;
  Function detectCountryOnError;
  Function detectCountryOnNext;
  Logger _logger;

  ProfilePresenter(AuthenticationRepository authRepo,
      NationalityRepository nationalityRepository,CountryRepository countryRepository,)
      : _getNationalitiesUseCase =
            GetNationalitiesUseCase(nationalityRepository),
        updateProfileUseCase = UpdateProfileUseCase(authRepo),
        _detectCountryUseCase = DetectCountryUseCase(countryRepository),
        _getCountriesUseCase = GetCountriesUseCase(countryRepository),
        super(authRepo) {
    _logger = Logger();
    fetchNationalities();
    fetchCountries();
  }

  @override
  void dispose() {
    super.dispose();
    updateProfileUseCase.dispose();
    _detectCountryUseCase.dispose();
    _getCountriesUseCase.dispose();
    _getNationalitiesUseCase.dispose();

  }

  detectCountry(){
    _detectCountryUseCase.execute(_DetectCountryObserver(this));
  }
  fetchCountries(){
    _getCountriesUseCase.execute(_GetCountriesUseCase(this));
  }

  void update(UpdateProfileParams params) {
    updateProfileUseCase.execute(_UpdateProfileObserver(this), params);
  }


  void fetchNationalities() {
    _getNationalitiesUseCase.execute(_NationalityObserver(this));
  }
}
class _NationalityObserver extends Observer<List<Nationality>>{
  ProfilePresenter _presenter;

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
class _UpdateProfileObserver extends Observer<Customer> {
  ProfilePresenter _presenter;

  _UpdateProfileObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.updateProfileOnComplete != null);
    _presenter.updateProfileOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.updateProfileOnError != null);
    _presenter.updateProfileOnError(e);
  }

  @override
  void onNext(Customer response) {
    assert(_presenter.updateProfileOnNext != null);
    _presenter.updateProfileOnNext(response);
  }
}
class _DetectCountryObserver extends Observer<IPDetectResponse> {
  final ProfilePresenter _presenter;

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
  final ProfilePresenter _presenter;

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
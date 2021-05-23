import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/entities/models/Nationality.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/nationality_repository.dart';
import 'package:coupon_app/domain/usercases/auth/get_nationality_usecase.dart';
import 'package:coupon_app/domain/usercases/auth/register_usecase.dart';
import 'package:coupon_app/domain/usercases/auth/update_profile_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class ProfilePresenter extends AuthPresenter {
  UpdateProfileUseCase updateProfileUseCase;
  GetNationalitiesUseCase _getNationalitiesUseCase;

  Function updateProfileOnComplete;
  Function updateProfileOnNext;
  Function updateProfileOnError;

  Function getNationalitiesOnComplete;
  Function getNationalitiesOnNext;
  Function getNationalitiesOnError;

  Logger _logger;

  ProfilePresenter(AuthenticationRepository authRepo,
      NationalityRepository nationalityRepository)
      : _getNationalitiesUseCase =
            GetNationalitiesUseCase(nationalityRepository),
        updateProfileUseCase = UpdateProfileUseCase(authRepo),
        super(authRepo) {
    _logger = Logger();
    fetchNationalities();
  }

  @override
  void dispose() {
    updateProfileUseCase.dispose();
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
class _UpdateProfileObserver extends Observer<Token> {
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
  void onNext(Token response) {
    assert(_presenter.updateProfileOnNext != null);
    _presenter.updateProfileOnNext(response);
  }
}

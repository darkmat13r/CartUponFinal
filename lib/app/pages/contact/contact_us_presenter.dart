import 'package:coupon_app/domain/entities/models/WebSetting.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:coupon_app/domain/usercases/get_websetting_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ContactUsPresenter extends Presenter{
  GetWebSettingsUseCase _getWebSettingsUseCase;

  Function getSettingsOnComplete;
  Function getSettingsOnNext;
  Function getSettingsOnError;

  ContactUsPresenter(HomeRepository homeRepository) : this._getWebSettingsUseCase = GetWebSettingsUseCase(homeRepository){
    _getWebSettingsUseCase.execute(_GetSettingsObserver(this));
  }

  @override
  void dispose() {
   _getWebSettingsUseCase.dispose();
  }

}

class _GetSettingsObserver extends Observer<WebSetting> {
  final ContactUsPresenter _presenter;


  _GetSettingsObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getSettingsOnComplete != null);
    _presenter.getSettingsOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getSettingsOnError != null);
    _presenter.getSettingsOnError(e);
  }

  @override
  void onNext(WebSetting response) {
    assert(_presenter.getSettingsOnNext != null);
    _presenter.getSettingsOnNext(response);
  }
}
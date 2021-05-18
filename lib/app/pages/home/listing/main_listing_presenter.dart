import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/entities/models/HomeData.dart';
import 'package:coupon_app/domain/entities/models/Token.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/banners/slider_repository.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:coupon_app/domain/usercases/auth/get_current_user_usecase.dart';
import 'package:coupon_app/domain/usercases/banner/get_sliders_use_case.dart';
import 'package:coupon_app/domain/usercases/get_home_page_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class MainListingPresenter extends AuthPresenter{
  GetHomePageUseCase _getHomePageUseCase;

  Function getHomePageOnComplete;
  Function getHomePageOnError;
  Function getHomePageOnNext;




  MainListingPresenter(HomeRepository _homeRepo, AuthenticationRepository authRepo) : super(authRepo){
    _getHomePageUseCase = GetHomePageUseCase(_homeRepo);
    _getHomePageUseCase.execute(_ProductsObserver(this));

  }

  @override
  void dispose() {
    _getHomePageUseCase.dispose();
  }
}

class _ProductsObserver extends Observer<HomeData>{
  MainListingPresenter _presenter;


  _ProductsObserver(this._presenter);

  @override
  void onComplete() {
    assert( _presenter.getHomePageOnComplete != null);
    _presenter.getHomePageOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getHomePageOnError != null);
    _presenter.getHomePageOnError(e);
  }

  @override
  void onNext(HomeData response) {
    assert(_presenter.getHomePageOnNext != null);
    _presenter.getHomePageOnNext(response);
  }

}
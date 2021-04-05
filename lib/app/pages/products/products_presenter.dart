import 'package:coupon_app/domain/entities/models/HomeData.dart';
import 'package:coupon_app/domain/repositories/banners/slider_repository.dart';
import 'package:coupon_app/domain/repositories/home_repository.dart';
import 'package:coupon_app/domain/usercases/banner/get_sliders_use_case.dart';
import 'package:coupon_app/domain/usercases/get_home_page_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';

class ProductsPresenter extends Presenter{
  GetHomePageUseCase _getHomePageUseCase;
  Function getHomePageOnComplete;
  Function getHomePageOnError;
  Function getHomePageOnNext;


  ProductsPresenter(HomeRepository _homeRepo) : _getHomePageUseCase = GetHomePageUseCase(_homeRepo){
    _getHomePageUseCase.execute(_ProductsObserver(this));
  }

  @override
  void dispose() {
    _getHomePageUseCase.dispose();
  }
}

class _ProductsObserver extends Observer<HomeData>{
  ProductsPresenter _presenter;


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
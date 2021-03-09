import 'package:coupon_app/domain/repositories/banners/slider_repository.dart';
import 'package:coupon_app/domain/usercases/banner/get_sliders_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
import 'package:coupon_app/domain/entities/slider_banner_entity.dart';

class ProductsPresenter extends Presenter{

  GetSlidersUseCase _getSlidersUseCase;

  Function getSlidersOnComplete;
  Function getSlidersOnNext;
  Function getSlidersOnError;

  Logger _logger;
  ProductsPresenter(SliderRepository _sliderRepo) : _getSlidersUseCase = GetSlidersUseCase(_sliderRepo){
    _logger = Logger("ProductsPresenter");
     _getSlidersUseCase.execute(_GetSlidersObserver(this));
  }


  @override
  void dispose() {
    _getSlidersUseCase.dispose();
  }

}

class _GetSlidersObserver extends Observer<List<SliderBannerEntity>> {

  ProductsPresenter _presenter;


  _GetSlidersObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getSlidersOnComplete != null);
    _presenter.getSlidersOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getSlidersOnError != null);
    _presenter.getSlidersOnError(e);
  }

  @override
  void onNext(List<SliderBannerEntity> response) {
    assert(_presenter.getSlidersOnNext != null);
    _presenter.getSlidersOnNext(response);
  }
}
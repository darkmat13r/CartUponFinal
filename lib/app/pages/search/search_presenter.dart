import 'package:coupon_app/domain/entities/coupons/category_detail_entity.dart';
import 'package:coupon_app/domain/entities/coupons/coupon_entity.dart';
import 'package:coupon_app/domain/repositories/coupon/coupon_repository.dart';
import 'package:coupon_app/domain/usercases/coupon/get_coupon_list_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class SearchPresenter extends Presenter{

  GetCouponListUseCase _getCouponListUseCase;

  Function getCouponsOnComplete;
  Function getCouponsOnError;
  Function getCouponsOnNext;

  Logger _logger;

  SearchPresenter(CouponRepository couponRepository) : _getCouponListUseCase = GetCouponListUseCase(couponRepository){
    _logger = Logger("SearchPresenter");
  }


  searchCouponCategory(CategoryDetailEntity category){
    _logger.finest(category);
    if(category != null){
      _getCouponListUseCase.execute(_GetCouponListObserver(this), CouponFilterParams(categoryId: category.category.id.toString()));
    }

  }

  @override
  void dispose() {
    _getCouponListUseCase.dispose();
  }
}

class _GetCouponListObserver extends Observer<List<CouponEntity>>{

  SearchPresenter _presenter;


  _GetCouponListObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getCouponsOnComplete != null);
    _presenter.getCouponsOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getCouponsOnError != null);
    _presenter.getCouponsOnError(e);
  }

  @override
  void onNext(List<CouponEntity> response) {
    assert(_presenter.getCouponsOnNext != null);
    _presenter.getCouponsOnNext(response);
  }

}
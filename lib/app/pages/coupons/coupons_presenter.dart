import 'package:coupon_app/domain/entities/coupons/category_detail_entity.dart';
import 'package:coupon_app/domain/repositories/coupon/category_repository.dart';
import 'package:coupon_app/domain/usercases/coupon/get_coupon_category_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class CouponPresenter extends Presenter{

  GetCouponCategoryUseCase _categoryUseCase;

  Logger _logger;

  Function getCouponCategoryOnComplete;
  Function getCouponCategoryOnError;
  Function getCouponCategoryOnNext;


  CouponPresenter(CouponCategoryRepository couponCategoryRepository): _categoryUseCase  = GetCouponCategoryUseCase(couponCategoryRepository){
    _logger = Logger('CouponPresenter');
    _categoryUseCase.execute(_GetCouponCategoriesObserver(this));
  }

  @override
  void dispose() {
    _categoryUseCase.dispose();
  }
}

class _GetCouponCategoriesObserver extends Observer<List<CategoryDetailEntity>> {
  CouponPresenter _presenter;


  _GetCouponCategoriesObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getCouponCategoryOnComplete != null);
    _presenter.getCouponCategoryOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getCouponCategoryOnError != null);
    _presenter.getCouponCategoryOnError(e);
  }

  @override
  void onNext(List<CategoryDetailEntity> response) {
    assert(_presenter.getCouponCategoryOnNext != null);
    _presenter.getCouponCategoryOnNext(response);
  }
}
import 'package:coupon_app/domain/entities/category_entity.dart';
import 'package:coupon_app/domain/entities/product_entity.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:coupon_app/domain/usercases/get_product_list_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class SearchPresenter extends Presenter{

  GetProductListUseCase _getCouponListUseCase;

  Function getCouponsOnComplete;
  Function getCouponsOnError;
  Function getCouponsOnNext;

  Logger _logger;

  SearchPresenter(ProductRepository couponRepository) : _getCouponListUseCase = GetProductListUseCase(couponRepository){
    _logger = Logger("SearchPresenter");
  }


  searchCouponCategory(CategoryEntity category){
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

class _GetCouponListObserver extends Observer<List<ProductEntity>>{

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
  void onNext(List<ProductEntity> response) {
    assert(_presenter.getCouponsOnNext != null);
    _presenter.getCouponsOnNext(response);
  }

}
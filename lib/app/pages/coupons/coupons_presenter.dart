import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:coupon_app/domain/repositories/category_repository.dart';
import 'file:///G:/Projects/Flutter/coupon_app/lib/domain/usercases/get_category_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class CouponPresenter extends Presenter{

  GetCouponCategoryUseCase _categoryUseCase;

  Logger _logger;

  Function getCategoryOnComplete;
  Function getCategoryOnError;
  Function getCategoryOnNext;


  CouponPresenter(CategoryRepository couponCategoryRepository): _categoryUseCase  = GetCouponCategoryUseCase(couponCategoryRepository){
    _logger = Logger('CouponPresenter');
    _categoryUseCase.execute(_GetCouponCategoriesObserver(this));
  }

  @override
  void dispose() {
    _categoryUseCase.dispose();
  }
}

class _GetCouponCategoriesObserver extends Observer<List<CategoryType>> {
  CouponPresenter _presenter;


  _GetCouponCategoriesObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getCategoryOnComplete != null);
    _presenter.getCategoryOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getCategoryOnError != null);
    _presenter.getCategoryOnError(e);
  }

  @override
  void onNext(List<CategoryType> response) {
    assert(_presenter.getCategoryOnNext != null);
    _presenter.getCategoryOnNext(response);
  }
}
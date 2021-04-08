import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:coupon_app/domain/repositories/category_repository.dart';
import 'package:coupon_app/domain/usercases/category/get_categories_use_case.dart';
import 'package:coupon_app/domain/usercases/category/get_category_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class CouponPresenter extends Presenter{

  GetCategoryUseCase _categoryUseCase;
  GetCategoryListUseCase _categoryListUseCase;

  Logger _logger;

  Function getCategoryOnComplete;
  Function getCategoryOnError;
  Function getCategoryOnNext;


  CouponPresenter(CategoryRepository categoryRepository): _categoryListUseCase  = GetCategoryListUseCase(categoryRepository){
    _logger = Logger('CouponPresenter');
    _categoryListUseCase.execute(_GetCategoriesObserver(this));
  }

  @override
  void dispose() {
    _categoryListUseCase.dispose();
    _categoryUseCase.dispose();
  }
}

class _GetCategoriesObserver extends Observer<List<CategoryType>> {
  CouponPresenter _presenter;


  _GetCategoriesObserver(this._presenter);

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
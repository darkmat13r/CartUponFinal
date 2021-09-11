import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/repositories/category_repository.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:coupon_app/domain/usercases/category/get_category_usecase.dart';
import 'package:coupon_app/domain/usercases/product/get_product_list_use_case.dart';
import 'package:coupon_app/domain/usercases/product/search_product_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class SearchPresenter extends Presenter {
  GetProductListUseCase _getProductListUseCase;
  GetCategoryUseCase _getCategoryUseCase;
  SearchProductUseCase _searchProductUseCase;

  Function getProductsOnComplete;
  Function getProductsOnError;
  Function getProductsOnNext;

  Function getCategoryOnComplete;
  Function getCategoryOnNext;
  Function getCategoryOnError;



  Logger _logger;

  SearchPresenter(ProductRepository productRepository,
      CategoryRepository categoryRepository)
      : _getProductListUseCase = GetProductListUseCase(productRepository),
       _searchProductUseCase = SearchProductUseCase(productRepository),
        _getCategoryUseCase = GetCategoryUseCase(categoryRepository) {
    _logger = Logger();
  }

  searchCategory(CategoryType category, {String filter}) {
    _logger.e(category);
    if (category != null) {
      _getProductListUseCase.execute(_GetProductListObserver(this),
          ProductFilterParams(categoryId: category.category.id.toString(), filterBy: filter));
    }
  }

  searchCategoryById(String categoryId, {String filter}) {
    _logger.e("SearchCategoryByID ${categoryId}");
    if (categoryId != null) {
      _getProductListUseCase.execute(_GetProductListObserver(this),
          ProductFilterParams(categoryId: categoryId.toString(), filterBy: filter));
      _getCategoryUseCase.execute(_GetCategoryObserver(this), categoryId);
    }
  }

  searchByQuery(String query, {String filter}){
    _searchProductUseCase.execute(_GetProductListObserver(this), SearchProductParams(query: query, filterBy: filter));
  }

  @override
  void dispose() {
    _getProductListUseCase.dispose();
  }
}

class _GetCategoryObserver extends Observer<CategoryType> {
  SearchPresenter _presenter;

  _GetCategoryObserver(this._presenter);

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
  void onNext(CategoryType response) {
    assert(_presenter.getCategoryOnNext != null);
    _presenter.getCategoryOnNext(response);
  }
}

class _GetProductListObserver extends Observer<List<ProductDetail>> {
  SearchPresenter _presenter;

  _GetProductListObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getProductsOnComplete != null);
    _presenter.getProductsOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getProductsOnError != null);
    _presenter.getProductsOnError(e);
  }

  @override
  void onNext(List<ProductDetail> response) {
    assert(_presenter.getProductsOnNext != null);
    _presenter.getProductsOnNext(response);
  }
}

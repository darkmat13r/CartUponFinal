import 'package:coupon_app/domain/entities/models/Category.dart';
import 'package:coupon_app/domain/entities/models/CategoryType.dart';
import 'package:coupon_app/domain/entities/models/Product.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/repositories/category_repository.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:coupon_app/domain/usercases/category/get_categories_use_case.dart';
import 'package:coupon_app/domain/usercases/product/get_product_list_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class ProductsPresenter extends Presenter {
  final GetCategoryListUseCase _getCategoryListUseCase;
  final GetProductListUseCase _getProductListUseCase;
  final String type;

  Function getCategoriesOnComplete;
  Function getCategoriesOnNext;
  Function getCategoriesOnError;


  Function getProductsOnComplete;
  Function getProductsOnError;
  Function getProductsOnNext;


  ProductsPresenter(this.type,
      CategoryRepository categoryRepository, ProductRepository productsRepo)
      : _getCategoryListUseCase = GetCategoryListUseCase(categoryRepository),_getProductListUseCase = GetProductListUseCase(productsRepo){
      fetchCategories();
      fetchProducts();
  }

  fetchCategories(){
    _getCategoryListUseCase.execute(_GetCategoriesObserver(this),type );
  }
  fetchProducts(){
    _getProductListUseCase.execute(_GetProductsObserver(this),ProductFilterParams(productType:  type) );
  }
  @override
  void dispose() {
    _getCategoryListUseCase.dispose();
    _getProductListUseCase.dispose();
  }
}


class _GetCategoriesObserver extends Observer<List<CategoryType>>{

  ProductsPresenter _presenter;


  _GetCategoriesObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getCategoriesOnComplete != null);
    _presenter.getCategoriesOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getCategoriesOnError != null);
    _presenter.getCategoriesOnError(e);
  }

  @override
  void onNext(List<CategoryType> response) {
    assert(_presenter.getCategoriesOnNext != null);
    _presenter.getCategoriesOnNext(response);
  }

}

class _GetProductsObserver extends Observer<List<ProductDetail>>{

  ProductsPresenter _presenter;


  _GetProductsObserver(this._presenter);

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
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/repositories/product_repository.dart';
import 'package:coupon_app/domain/usercases/product/get_product_list_use_case.dart';
import 'package:coupon_app/domain/usercases/product/get_product_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logging/logging.dart';
class ProductPresenter extends Presenter{

  GetProductUseCase _getProductUseCase;
  GetProductListUseCase _productListUseCase;

  Function getProductOnComplete;
  Function getProductOnError;
  Function getProductOnNext;

  Function getSimilarProductOnComplete;
  Function getSimilarProductOnError;
  Function getSimilarProductOnNext;

  Logger _logger;

  ProductPresenter(ProductDetail productDetail , ProductRepository productRepository) : _getProductUseCase = GetProductUseCase(productRepository), _productListUseCase = GetProductListUseCase(productRepository){
    _logger = Logger("ProductPresenter");
    _getProductUseCase.execute(_GetProductObserver(this),( productDetail.id ?? "").toString());
    _productListUseCase.execute(_GetSimilarProductObserver(this), ProductFilterParams(categoryId: productDetail.product.category_id.toString()));
  }



  @override
  void dispose() {
    _getProductUseCase.dispose();
  }

}
class _GetSimilarProductObserver extends Observer<List<ProductDetail>>{
  ProductPresenter _presenter;


  _GetSimilarProductObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.getSimilarProductOnComplete != null);
    _presenter.getSimilarProductOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getSimilarProductOnError != null);
    _presenter.getSimilarProductOnError(e);
  }

  @override
  void onNext(List<ProductDetail> response) {
    assert(_presenter.getSimilarProductOnNext != null);
    _presenter.getSimilarProductOnNext(response);
  }

}

class _GetProductObserver extends Observer<ProductDetail>{

  ProductPresenter _presenter;


  _GetProductObserver(this._presenter);


  @override
  void onComplete() {
    assert(_presenter.getProductOnComplete != null);
    _presenter.getProductOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getProductOnError != null );
    _presenter.getProductOnError(e);
  }

  @override
  void onNext(ProductDetail response) {
    assert(_presenter.getProductOnNext != null);
    _presenter.getProductOnNext(response);
  }

}
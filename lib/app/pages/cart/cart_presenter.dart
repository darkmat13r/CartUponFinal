import 'package:coupon_app/domain/entities/cart.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:coupon_app/domain/usercases/cart/get_cart_items_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CartPresenter extends Presenter{

  GetCartItemsUseCase _cartItemsUseCase;

  Function getCartOnNext;
  Function getCartOnError;
  Function getCartOnComplete;

  CartPresenter(CartRepository repository):_cartItemsUseCase = GetCartItemsUseCase(repository){
    _cartItemsUseCase.execute(_GetCartObserver(this));
  }

  @override
  void dispose() {
    _cartItemsUseCase.dispose();
  }

}

class _GetCartObserver extends Observer<Cart> {
  CartPresenter _presenter;


  _GetCartObserver(this._presenter);

  @override
  void onComplete() {
   assert(_presenter.getCartOnComplete != null);
   _presenter.getCartOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.getCartOnError != null);
    _presenter.getCartOnError(e);
  }

  @override
  void onNext(Cart response) {
    assert(_presenter.getCartOnNext != null);
    _presenter.getCartOnNext(response);
  }
}
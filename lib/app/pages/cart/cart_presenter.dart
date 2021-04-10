import 'package:coupon_app/domain/entities/cart.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:coupon_app/domain/usercases/cart/add_to_cart_use_case.dart';
import 'package:coupon_app/domain/usercases/cart/delete_cart_item_use_case.dart';
import 'package:coupon_app/domain/usercases/cart/get_cart_items_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CartPresenter extends Presenter{

  GetCartItemsUseCase _cartItemsUseCase;
  DeleteCartItemUseCase _deleteCartItemUseCase;
  AddToCartUseCase _addToCartUseCase;

  Function getCartOnNext;
  Function getCartOnError;
  Function getCartOnComplete;

  Function addToCartOnNext;
  Function addToCartOnComplete;
  Function addToCartOnError;

  Function deleteCartItemOnNext;
  Function deleteCartItemOnComplete;
  Function deleteCartItemOnError;

  CartPresenter(CartRepository repository):_cartItemsUseCase = GetCartItemsUseCase(repository),
        _deleteCartItemUseCase = DeleteCartItemUseCase(repository), _addToCartUseCase = AddToCartUseCase(repository){
    fetchCart();
  }

  fetchCart(){
    _cartItemsUseCase.execute(_GetCartObserver(this));
  }

  delete(CartItem item){
    _deleteCartItemUseCase.execute(_DeleteCartItemObserver(this), item);
  }


  addToCart(CartItem item){
    _addToCartUseCase.execute(_GetCartObserver(this), item);
  }


  @override
  void dispose() {
    _cartItemsUseCase.dispose();
  }

}

class _AddToCartItemObserver extends Observer<CartItem>{
  CartPresenter _presenter;

  _AddToCartItemObserver(this._presenter);
  @override
  void onComplete() {
    assert(_presenter.addToCartOnComplete != null);
    _presenter.addToCartOnComplete();
  }

  @override
  void onError(e) {
   assert(_presenter.addToCartOnError != null);
   _presenter.addToCartOnError(e);
  }

  @override
  void onNext(CartItem response) {
    assert(_presenter.addToCartOnNext != null);
    _presenter.addToCartOnNext(response);
  }

}

class _DeleteCartItemObserver extends Observer<void>{
  CartPresenter _presenter;

  _DeleteCartItemObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.deleteCartItemOnComplete != null);
    _presenter.deleteCartItemOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.deleteCartItemOnError != null);
    _presenter.deleteCartItemOnError(e);
  }

  @override
  void onNext(void response) {
    assert(_presenter.deleteCartItemOnNext != null);
    _presenter.deleteCartItemOnNext(response);
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
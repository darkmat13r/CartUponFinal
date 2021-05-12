import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/cart/cart_presenter.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/cart.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CartController extends BaseController{

  CartPresenter _presenter;

  Cart cart;

  CartController(CartRepository cartRepository) : this._presenter = CartPresenter(cartRepository){
    showLoading();
  }

  @override
  void initListeners() {
    _presenter.getCartOnNext = getCartOnNext;
    _presenter.getCartOnError = getCartOnError;
    _presenter.getCartOnComplete = getCartOnComplete;

    _presenter.updateCartOnNext = (cartItem){
      dismissLoading();
    };
    _presenter.updateCartOnError = (e){
      dismissLoading();
      showGenericSnackbar(getContext(), e.message, isError : true);
      _presenter.fetchCart();
    };
    _presenter.updateCartOnComplete = (){
      _presenter.fetchCart();
    };
    _presenter.deleteCartItemOnNext = (res){
    };
    _presenter.deleteCartItemOnError = (e){
      _presenter.fetchCart();
    //  showGenericSnackbar(getContext(), e.message, isError : true);
    };
    _presenter.deleteCartItemOnComplete = (){
      _presenter.fetchCart();
     // CartStream().fetchQuantity();
    };
  }

  updateCart(CartItem cartItem , int qty){
    cartItem.qty = qty;
    var foundItem = cart.cartItems.firstWhere((element) => element.id == cartItem.id);
    if(foundItem != null){
      foundItem.qty = qty;
      getCartOnNext(cart);
    }
    cart =  getCart(cart.cartItems);
    _presenter.updateQty(cartItem);
    refreshUI();
  }

  getCart( List<CartItem> cartItems ){
    double total = 0;
    int quantity = 0;
    cartItems.forEach((element) {
      String price = "0";
      if (element.variant_value_id != null) {
        price = element.variant_value_id.price;
      } else {
        price = element.product_id.sale_price;
      }
      total += double.parse(price) * element.qty;
      quantity += element.qty;
    });

    return Cart(quantity: quantity, cartItems: cartItems, total: total);
  }
  removeItem(CartItem cartItem){
    showGenericConfirmDialog(getContext(), LocaleKeys.alert.tr() , LocaleKeys.confirmRemoveCartItem.tr(),onConfirm: (){
      cart.cartItems.remove(cartItem);
      refreshUI();
      _presenter.delete(cartItem);

    });
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  getCartOnNext(Cart cart) {
    this.cart = cart;
    CartStream().updateCart(cart);
    refreshUI();
  }

  getCartOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: false);
  }

  getCartOnComplete() {
    dismissLoading();
  }
}
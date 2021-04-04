import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/cart/cart_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/cart.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CartController extends BaseController{

  CartPresenter _presenter;

  Cart cart;

  CartController(CartRepository cartRepository) : this._presenter = CartPresenter(cartRepository);

  @override
  void initListeners() {
    _presenter.getCartOnNext = getCartOnNext;
    _presenter.getCartOnError = getCartOnError;
    _presenter.getCartOnComplete = getCartOnComplete;
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  getCartOnNext(Cart cart) {
    this.cart = cart;
    refreshUI();
  }

  getCartOnError(e) {
    dismissLoading();
    print(e);
    showGenericSnackbar(getContext(), e.message);
  }

  getCartOnComplete() {
    dismissLoading();
  }
}
import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/cart/cart_presenter.dart';
import 'package:coupon_app/app/pages/login/login_view.dart';
import 'package:coupon_app/app/pages/otp/request/request_otp_view.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/register/register_view.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/Cart.dart';
import 'package:coupon_app/domain/entities/models/CartItem.dart';
import 'package:coupon_app/domain/entities/models/ProductDetail.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CartController extends BaseController {
  CartPresenter _presenter;

  Cart cart;

  CartController(
      AuthenticationRepository authRepo, CartRepository cartRepository)
      : this._presenter = CartPresenter(authRepo, cartRepository) {
    showLoading();
  }

  @override
  void initListeners() {
    initBaseListeners(_presenter);
    _presenter.getCartOnNext = getCartOnNext;
    _presenter.getCartOnError = getCartOnError;
    _presenter.getCartOnComplete = getCartOnComplete;

    _presenter.updateCartOnNext = (cartItem) {
      dismissLoading();
    };
    _presenter.updateCartOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getContext(), e.message, isError: true);
      _presenter.fetchCart();
    };
    _presenter.updateCartOnComplete = () {
      _presenter.fetchCart();
    };
    _presenter.deleteCartItemOnNext = (res) {};
    _presenter.deleteCartItemOnError = (e) {
      showProgressDialog();
      _presenter.fetchCart();
      //  showGenericSnackbar(getContext(), e.message, isError : true);
    };
    _presenter.deleteCartItemOnComplete = () {
      showProgressDialog();
      _presenter.fetchCart();

      // CartStream().fetchQuantity();
    };
  }

  updateCart(CartItem cartItem, int qty) {
    showProgressDialog();
    cartItem.qty = qty;
    _presenter.updateQty(cartItem);
    refreshUI();
  }

  removeItem(CartItem cartItem) {
    showGenericConfirmDialog(getContext(), LocaleKeys.alert.tr(),
        LocaleKeys.confirmRemoveCartItem.tr(), onConfirm: () {
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
    dismissProgressDialog();
  }

  getCartOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: false);
  }

  getCartOnComplete() {
    dismissLoading();
  }

  void showProductDetails(String productId) {
    AppRouter().productDetailsById(getContext(), productId);
  }

  proceedCheckout() {
    Navigator.of(getContext()).pushNamed(Pages.checkout);
  }

  void checkout() async {
    bool itemOutOfStock = false;
    for (var item in cart.cart) {
      if (item.product_id.stock <= 0) {
        itemOutOfStock = true;
        break;
      }
    }
    if (currentUser != null && !itemOutOfStock) {
      proceedCheckout();
    } else if (itemOutOfStock) {
      showGenericDialog(getContext(), LocaleKeys.outOfStockTitle.tr(), LocaleKeys.outOfStockMessage.tr());
    } else {
      var dialogContext;
      showLoginPopup(getContext(), onCreate: (BuildContext context) {
        dialogContext = context;
      },
          guestText: LocaleKeys.continueAsGuest.tr(),
          onGuestSelected: onGuestSelected,
          onLoginSelected: onLoginSelected,
          onRegisterSelected: onRegisterSelected);
    }
  }

  onGuestSelected(context) async {
    proceedCheckout();
  }

  onLoginSelected(context) async {
    var user = await Navigator.of(getContext()).push(MaterialPageRoute(
        builder: (context) => LoginPage(
              returnResult: true,
            )));
    proceedCheckout();
  }

  onRegisterSelected(context) async {
    var result = await Navigator.of(getContext()).push(MaterialPageRoute(
        builder: (context) => RequestOtpPage(
              returnResult: true,
            )));
    if (result is Map) {
      var mobile = result['mobile'];
      var countryCode = result['country_code'];
      var user = await Navigator.of(getContext()).push(MaterialPageRoute(
          builder: (context) => RegisterPage(
                mobileNumber: mobile,
                countryCode: countryCode,
                returnResult: true,
              )));
      proceedCheckout();
    }
  }
}

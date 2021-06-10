import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/account/address/addresses_view.dart';
import 'package:coupon_app/app/pages/checkout/checkout_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/Cart.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class CheckoutController extends BaseController {
  final CheckoutPresenter _presenter;
  Cart cart;

  List<Address> addresses;

  Address defaultAddress;

  Logger _logger;

  CheckoutController(AddressRepository addressRepo, CartRepository cartRepo)
      : this._presenter = CheckoutPresenter(addressRepo, cartRepo) {
    _logger = Logger();
    showLoading();
  }

  @override
  void initListeners() {
    _presenter.getCartOnNext = getCartOnNext;
    _presenter.getCartOnError = getCartOnError;
    _presenter.getCartOnComplete = getCartOnComplete;

    initAddressListeners();
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

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void initAddressListeners() {
    _presenter.getAddressesOnNext = _getAddressOnNext;
    _presenter.getAddressesOnComplete = () {
      dismissLoading();
    };
    _presenter.getAddressesOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getContext(), e.message);
    };
  }
  void addAddress() async {
    await Navigator.of(getContext()).pushNamed(Pages.addAddress);
    _presenter.fetchAddresses();
  }

  Future<void> changeAddress() async {
    final result = await Navigator.push(
      getContext(),
      MaterialPageRoute(builder: (context) => AddressesPage(selectionMode: true,)),
    );
    this.defaultAddress = result;
    refreshUI();
  }

  _getAddressOnNext(List<Address> addresses) {
    this.addresses = addresses;
    if(addresses.length > 0){
      try{
        defaultAddress =  addresses.firstWhere((element) => element.is_default);
      }catch(e){
        defaultAddress = addresses.first;
      }
    }
    refreshUI();
  }
}

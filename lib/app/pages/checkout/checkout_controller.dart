import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/account/address/addresses_view.dart';
import 'package:coupon_app/app/pages/checkout/checkout_presenter.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/Cart.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:coupon_app/domain/repositories/cart/cart_repository.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class CheckoutController extends BaseController {
  final CheckoutPresenter _presenter;
  Cart cart;

  List<Address> addresses;

  Address defaultAddress;

  int paymentMethod;

  Logger _logger;
  
  bool containsCoupon = false;

  CheckoutController(AddressRepository addressRepo, CartRepository cartRepo, OrderRepository orderRepository)
      : this._presenter = CheckoutPresenter(addressRepo, cartRepo, orderRepository) {
    _logger = Logger();
    showLoading();
  }

  @override
  void initListeners() {
    _presenter.getCartOnNext = getCartOnNext;
    _presenter.getCartOnError = getCartOnError;
    _presenter.getCartOnComplete = getCartOnComplete;

    initAddressListeners();
    initPlaceOrderListeners();
  }

  getCartOnNext(Cart cart) {
    this.cart = cart;
    Logger().e(cart);
    try{
      var item =  cart.cart.firstWhere((element) => !element.product_id.category_type);
      if(item != null){
        containsCoupon = true;
      }
    }catch(e){
      Logger().e(e);
    }
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
  void showProductDetails(String productId){
    AppRouter().productDetailsById(getContext(), productId);
  }
  void setPaymentMethod(int value) {
    this.paymentMethod = value;
    refreshUI();
  }

  void placeOrder() {
    if(defaultAddress == null){
      showGenericSnackbar(getContext(), LocaleKeys.errorSelectAddress.tr(), isError: true);
      return;
    }
    if(paymentMethod == 0 || paymentMethod == null){
      showGenericSnackbar(getContext(), LocaleKeys.errorSelectPaymentMethod.tr(), isError: true);
      return;
    }
    showProgressDialog();
    _presenter.placeOrder(defaultAddress.id, defaultAddress.id, paymentMethod == 1? "cash" : "online");
  }

  onCashOnDeliverOrderSuccess(){
    Navigator.of(getContext()).pushReplacementNamed(Pages.main);
    CartStream().clear();
  }
  void initPlaceOrderListeners() {
    _presenter.placeOrderOnComplete = (){
      dismissProgressDialog();
      if(paymentMethod == 1){

        showGenericConfirmDialog(getContext(), LocaleKeys.order.tr(), LocaleKeys.msgOrderSuccess.tr(),showCancel: false, onConfirm: (){
          onCashOnDeliverOrderSuccess();
        }, onCancel: (){
          onCashOnDeliverOrderSuccess();
        });
      }
    };
    _presenter.placeOrderOnNext = (PlaceOrderResponse response){
      _logger.e(response.paymentURL);
      dismissProgressDialog();
      if(response.paymentURL  != null){
        AppRouter().payment(getContext(), response.paymentURL);
      }
    };
    _presenter.placeOrderOnError = (e){
      _logger.e(e);
      showGenericSnackbar(getContext(), e.message, isError: true);
      dismissProgressDialog();
    };
  }
}

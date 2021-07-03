import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/account/address/add/add_address_view.dart';
import 'package:coupon_app/app/pages/account/address/addresses_view.dart';
import 'package:coupon_app/app/pages/account/guest/guest_info_view.dart';
import 'package:coupon_app/app/pages/checkout/checkout_presenter.dart';
import 'package:coupon_app/app/pages/otp/request/request_otp_view.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/app/utils/utility.dart';
import 'package:coupon_app/domain/entities/Cart.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/repositories/address_repository.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
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
  bool containsOnlyCoupon = false;
  bool useWallet = false;
  bool enableUseWallet = false;
  double amountToPay = 0;
  String countryCode;
  String mobileNumber;

  CheckoutController(
      AuthenticationRepository authRepo,
      AddressRepository addressRepo,
      CartRepository cartRepo,
      OrderRepository orderRepository)
      : this._presenter = CheckoutPresenter(
            authRepo, addressRepo, cartRepo, orderRepository) {
    _logger = Logger();
    paymentMethod = 0;
    showLoading();
  }

  @override
  void initListeners() {
    initBaseListeners(_presenter);
    _presenter.getCartOnNext = getCartOnNext;
    _presenter.getCartOnError = getCartOnError;
    _presenter.getCartOnComplete = getCartOnComplete;

    initAddressListeners();
    initPlaceOrderListeners();
  }

  toggleUseWallet() {
    this.useWallet = !this.useWallet;
    if (this.useWallet && paymentMethod == 1) {
      paymentMethod = 2;
    }
    verifyAmount();
    refreshUI();
  }

  verifyAmount() {
    if (currentUser != null) {
      var amount = double.tryParse(currentUser.wallet_balance) ?? 0;
      if (useWallet && amount > cart.net_total) {
        amountToPay = 0;
        paymentMethod = 3;
        return;
      }
    }
    amountToPay = cart.net_total;
  }

  @override
  onAuthComplete() {
    super.onAuthComplete();
    if (currentUser != null) {
      var amount = double.tryParse(currentUser.wallet_balance) ?? 0;
      enableUseWallet = amount > 0;
      refreshUI();
    }
  }

  getAmountToPay() {
    verifyAmount();
    return Utility.currencyFormat(amountToPay);
  }

  getCartOnNext(Cart cart) {
    this.cart = cart;
    try {
      var item = cart.cart.firstWhere(
          (element) => element.product_id.category_type == false,
          orElse: null);
      containsCoupon = item != null;
      _logger.e("Container Coupon ${containsCoupon}");
    } catch (e) {
      _logger.e(e);
    }

    CartStream().updateCart(cart);
    refreshUI();
    dismissProgressDialog();

    try {
      var anyProduct = cart.cart.firstWhere(
          (element) => element.product_id.category_type == true,
          orElse: null);
      containsOnlyCoupon = containsCoupon && anyProduct == null;
    } catch (e) {
      containsOnlyCoupon = containsCoupon;
      refreshUI();
    }
    if (currentUser != null && containsOnlyCoupon == false) {
      _presenter.fetchAddresses();
    } else {
      dismissLoading();
    }
  }

  getCartOnError(e) {
    dismissLoading();
    showGenericSnackbar(getContext(), e.message, isError: false);
  }

  getCartOnComplete() {}

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
    if (currentUser != null) {
      await Navigator.of(getContext()).pushNamed(Pages.addAddress);
      _presenter.fetchAddresses();
    }
  }

  Future<void> changeAddress() async {
    if (currentUser != null) {
      final result = await Navigator.push(
        getContext(),
        MaterialPageRoute(
            builder: (context) => AddressesPage(
                  selectionMode: true,
                )),
      );
      this.defaultAddress = result;
      refreshUI();
    }
  }

  _getAddressOnNext(List<Address> addresses) {
    this.addresses = addresses;
    if (addresses.length > 0) {
      try {
        defaultAddress = addresses.firstWhere((element) => element.is_default);
      } catch (e) {
        defaultAddress = addresses.first;
      }
    }
    refreshUI();
  }

  void showProductDetails(String productId) {
    AppRouter().productDetailsById(getContext(), productId);
  }

  void setPaymentMethod(int value) {
    this.paymentMethod = value;
    refreshUI();
  }

  addressRequired() {
    return (currentUser != null && !containsOnlyCoupon);
  }

  void placeOrder() {
    if (currentUser != null) {
      authCheckout();
    } else {
      //Guest Checkout
      verifyOtp();
    }
  }

  onCashOnDeliverOrderSuccess() {
    Navigator.of(getContext()).pushReplacementNamed(Pages.main);
    CartStream().clear();
  }

  void initPlaceOrderListeners() {
    _presenter.placeOrderOnComplete = () {
      dismissProgressDialog();
      if (paymentMethod == 1 || paymentMethod == 3) {
        showGenericConfirmDialog(getContext(), LocaleKeys.order.tr(),
            LocaleKeys.msgOrderSuccess.tr(),
            showCancel: false, onConfirm: () {
          onCashOnDeliverOrderSuccess();
        }, onCancel: () {
          onCashOnDeliverOrderSuccess();
        });
      }
    };
    _presenter.placeOrderOnNext = (PlaceOrderResponse response) {
      _logger.e(response.paymentURL);
      dismissProgressDialog();
      if (response.paymentURL != null) {
       startPaymentPage(response.paymentURL);
      }
    };
    _presenter.placeOrderOnError = (e) {
      _logger.e(e);
      showGenericSnackbar(getContext(), e.message, isError: true);
      dismissProgressDialog();
    };
  }

  void guestCheckout(String countryCode, String mobile) async {
    final result = await Navigator.push(
      getContext(),
      MaterialPageRoute(
          builder: (context) => GuestInfoPage(
                payMode: paymentMethod,
                onlyCoupon: containsOnlyCoupon,
                mobileNumber: mobileNumber,
                countryCode: countryCode,
                useWallet: useWallet,
              )),
    );
    Navigator.pop(getContext());
  }

  void verifyOtp() async {
    var result = await Navigator.of(getContext()).push(MaterialPageRoute(
        builder: (context) => RequestOtpPage(
              returnResult: true,
            )));
    if (result is Map) {
      this.mobileNumber = result['mobile'];
      this.countryCode = result['country_code'];
      guestCheckout(countryCode, mobileNumber);
    } else {
      showGenericSnackbar(
          getContext(), "You need to verify phone number in order to continue",
          isError: true);
      Navigator.pop(getContext());
    }
  }

  void authCheckout() {
    if (addressRequired()) {
      if (defaultAddress == null) {
        showGenericSnackbar(
            getContext(),
            containsOnlyCoupon
                ? LocaleKeys.errorAddDeliveryDetails.tr()
                : LocaleKeys.errorSelectAddress.tr(),
            isError: true);
        return;
      }
    }
    if (paymentMethod == 0 || paymentMethod == null) {
      showGenericSnackbar(
          getContext(), LocaleKeys.errorSelectPaymentMethod.tr(),
          isError: true);
      return;
    }
    showProgressDialog();
    var addressId = defaultAddress != null ? defaultAddress.id : 1;
    _presenter.placeOrder(addressId, addressId,
        paymentMethod == 1 && paymentMethod != 3 ? "cash" : "online",
        isGuest: currentUser == null,
        address: defaultAddress,
        useWallet: useWallet);
  }

  void startPaymentPage(String paymentUrl) async{
    var result = await AppRouter().payment(getContext(), paymentUrl);
    if(result ?? false){
      Navigator.of(getContext()).pushReplacementNamed(Pages.home);
    }
  }
}

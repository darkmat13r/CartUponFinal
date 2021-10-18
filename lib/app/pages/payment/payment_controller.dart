import 'dart:convert';

import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/Cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/payment/payment_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/user_entity.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentController extends BaseController {
  PaymentPresenter _presenter;
  WebViewController webViewController;
  var progressHUD;
  var result = false;

  PaymentController(authRepo) : _presenter = PaymentPresenter(authRepo) {
    isLoading = true;
  }

  @override
  void initListeners() {}

  Future<bool> onWillPop() {
    Logger().e("OnWillPOp ${result}");
    Navigator.of(getContext()).pop(result);
  }

  void processResponse(String message, bool isWallet) async {
    Map<String, dynamic> response = jsonDecode(message);
    Logger().e("PaymentResponse ${message}");
    loadEmptyUrl();
    if (response['Result'] == "COMPLETED" ||
        response['Result'] == "APPROVED" ||
        response['Result'] == "CAPTURED") {
      CartStream().clear();
      showGenericConfirmDialog(
          getContext(),
          isWallet ? LocaleKeys.walletTitle.tr() : LocaleKeys.order.tr(),
          isWallet
              ? LocaleKeys.msgWalletSuccess.tr()
              : LocaleKeys.msgOrderSuccess.tr(),
          showCancel: false, onCancel: () {
        paymentSuccessRedirect(isWallet);
      }, onConfirm: () {
        paymentSuccessRedirect(isWallet);
      });
    } else {
      showGenericConfirmDialog(
          getContext(),
          LocaleKeys.error.tr(),
          isWallet
              ? LocaleKeys.errorWalletFailed.tr(args: [response['TranID']])
              : LocaleKeys.msgOrderPaymentFailed.tr(args: [response['TranID']]),
          showCancel: false, onConfirm: () {
        result = false;
        Navigator.of(getContext()).pop(false);
      });
    }
    // ;
  }

  void loadEmptyUrl(){
    if(webViewController != null){
      webViewController.loadUrl('about:blank');
    }
  }

  void paymentSuccessRedirect(bool isWallet) {
    result = true;
    if (isWallet) {
      Navigator.of(getContext()).pop(true);
    } else {
      Navigator.of(getContext()).pushReplacementNamed(Pages.main);
    }
  }
}

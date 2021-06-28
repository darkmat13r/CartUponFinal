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

class PaymentController extends BaseController {
  PaymentPresenter _presenter;
  var progressHUD;

  PaymentController(authRepo) : _presenter = PaymentPresenter(authRepo) {
    isLoading = true;
  }

  @override
  void initListeners() {}



  void processResponse(String message, bool isWallet) async {
    Map<String, dynamic> response = jsonDecode(message);
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
          showCancel: false, onConfirm: () {
        if (isWallet) {
          Navigator.of(getContext()).pop(true);
        } else {
          Navigator.of(getContext()).pushReplacementNamed(Pages.main);
        }
      });
    } else {
      showGenericConfirmDialog(
          getContext(),
          LocaleKeys.error.tr(),
          isWallet
              ? LocaleKeys.errorWalletFailed.tr(args: [response['TranID']])
              : LocaleKeys.msgOrderPaymentFailed.tr(args: [response['TranID']]),
          showCancel: false, onConfirm: () {
        Navigator.of(getContext()).pop(false);
      });
    }
    // ;
  }
}

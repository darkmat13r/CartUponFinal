import 'dart:convert';

import 'package:coupon_app/app/utils/cart_stream.dart';
import 'package:coupon_app/app/utils/locale_keys.dart';
import 'package:coupon_app/domain/entities/Cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/payment/payment_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/user_entity.dart';

class PaymentController extends Controller {
  PaymentPresenter _presenter;
  var progressHUD;
  bool isLoading = false;

  PaymentController(authRepo) : _presenter = PaymentPresenter(authRepo);

  @override
  void initListeners() {}

  void dismissLoading() {
    isLoading = false;
    //ProgressHUD.of(getContext()).dismiss();
  }

  void processResponse(String message) async {
    Map<String, dynamic> response = jsonDecode(message);
    if (response['Result'] == "COMPLETED" || response['Result'] == "APPROVED"  || response['Result'] == "CAPTURED"  ) {
      CartStream().clear();
      showGenericConfirmDialog(
          getContext(), LocaleKeys.order.tr(), LocaleKeys.msgOrderSuccess.tr(),
          showCancel: false,
          onConfirm: () {
        Navigator.of(getContext()).pushReplacementNamed(Pages.main);
      });
    } else {
      showGenericConfirmDialog(getContext(), LocaleKeys.error.tr(),
          LocaleKeys.msgOrderPaymentFailed.tr(args: [response['TranID']]),
          showCancel: false, onConfirm: () {
        Navigator.of(getContext()).pop();
      });
    }
    // ;
  }
}

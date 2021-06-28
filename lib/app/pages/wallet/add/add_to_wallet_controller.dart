import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/payment/payment_view.dart';
import 'package:coupon_app/app/pages/wallet/add/add_to_wallet_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/app/utils/router.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/wallet_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class AddToWalletController extends BaseController {
  final AddToWalletPresenter _presenter;
  Logger _logger;
  bool showError = false;
  bool showSuccess = false;

  TextEditingController amountTextController;

  AddToWalletController(
      AuthenticationRepository authRepo, WalletRepository walletRepository)
      : _presenter = AddToWalletPresenter(authRepo,walletRepository) {
    _logger = Logger();
    amountTextController = TextEditingController();
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  @override
  onAuthComplete() {
    dismissProgressDialog();
     super.onAuthComplete();
  }

  @override
  onAuthError(e) {
    dismissProgressDialog();
     super.onAuthError(e);
  }

  void checkForm(Map<String, dynamic> params) {
    dynamic formKey = params['formKey'];
    assert(formKey is GlobalKey<FormState>);
    if (formKey.currentState.validate()) {
      requestPayment();
    }
  }

  @override
  void initListeners() {
    initBaseListeners(_presenter);
    initAddToWalletRequestListener();
  }

  void initAddToWalletRequestListener() async {
    _presenter.addToWalletOnComplete = () {
      dismissLoading();
    };
    _presenter.addToWalletOnNext = (PlaceOrderResponse response) async {
      if (response.paymentURL != null) {
        final result = await Navigator.push(
          getContext(),
          MaterialPageRoute(
              builder: (context) => PaymentPage(
                    response.paymentURL,
                    wallet: true,
                  )),
        );
        Navigator.pop(getContext(), result);
      }
    };
    _presenter.addToWalletOnError = (e) {
      showGenericSnackbar(getContext(), e.message, isError: true);
    };
  }

  close() {
    Navigator.of(getContext()).pop();
  }

  void requestPayment() {
    showLoading();
    _presenter.requestMoney(amountTextController.text);
  }
}

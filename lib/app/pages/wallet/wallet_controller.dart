import 'package:coupon_app/app/base_controller.dart';
import 'package:coupon_app/app/pages/pages.dart';
import 'package:coupon_app/app/pages/wallet/wallet_presenter.dart';
import 'package:coupon_app/app/utils/constants.dart';
import 'package:coupon_app/domain/entities/models/WalletHistoryResponse.dart';
import 'package:coupon_app/domain/entities/models/WalletTransaction.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/wallet_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class WalletController extends BaseController {
  WalletHistoryResponse transactions;

  final WalletPresenter _presenter;

  WalletController(
      AuthenticationRepository authRepo, WalletRepository walletRepository)
      : _presenter = WalletPresenter(authRepo, walletRepository){
    showLoading();
  }

  @override
  void initListeners() {
    initBaseListeners(_presenter);
    initWalletHistoryListener();
  }
  @override
  onAuthComplete() {
    super.onAuthComplete();
    _presenter.fetchHistory();
  }

  void initWalletHistoryListener() {
    _presenter.getWalletHistoryOnComplete = () {
      dismissLoading();
    };
    _presenter.getWalletHistoryOnNext = (response) {
      transactions = response;
      refreshUI();
    };
    _presenter.getWalletHistoryOnError = (e) {
      dismissLoading();
      showGenericSnackbar(getContext(), e.message, isError: true);
    };
  }

  @override
  void onDisposed() {
    _presenter.dispose();
    super.onDisposed();
  }

  void addMoneyToWallet() async {
    var result =
        await Navigator.of(getContext()).pushNamed(Pages.addMoneyToWallet);
    if (result != null && result) {
      showLoading();
      fetchUser();
    }
  }
}

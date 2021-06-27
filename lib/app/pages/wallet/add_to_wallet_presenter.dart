import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/wallet_repository.dart';
import 'package:coupon_app/domain/usercases/wallet/add_to_wallet_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddToWalletPresenter extends AuthPresenter {
  final AddToWalletUseCase _addToWalletUseCase;
  Function addToWalletOnComplete;
  Function addToWalletOnError;
  Function addToWalletOnNext;

  AddToWalletPresenter(
      AuthenticationRepository authRepo, WalletRepository walletRepo)
      : _addToWalletUseCase = AddToWalletUseCase(walletRepo), super(authRepo);

  requestMoney(String amount) {
    _addToWalletUseCase.execute(_AddToWalletObserver(this), amount);
  }

  @override
  void dispose() {
    _addToWalletUseCase.dispose();
  }
}

class _AddToWalletObserver extends Observer<PlaceOrderResponse> {
  final AddToWalletPresenter _presenter;

  _AddToWalletObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.addToWalletOnComplete != null);
    _presenter.addToWalletOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.addToWalletOnError != null);
    _presenter.addToWalletOnError(e);
  }

  @override
  void onNext(PlaceOrderResponse response) {
    assert(_presenter.addToWalletOnNext != null);
    _presenter.addToWalletOnNext(response);
  }
}

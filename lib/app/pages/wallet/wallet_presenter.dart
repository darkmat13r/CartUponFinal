import 'package:coupon_app/app/auth_presenter.dart';
import 'package:coupon_app/domain/entities/models/WalletHistoryResponse.dart';
import 'package:coupon_app/domain/entities/models/WalletTransaction.dart';
import 'package:coupon_app/domain/repositories/authentication_repository.dart';
import 'package:coupon_app/domain/repositories/wallet_repository.dart';
import 'package:coupon_app/domain/usercases/wallet/get_wallet_history_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class WalletPresenter extends AuthPresenter {
  final GetWalletHistoryUseCase _getWalletHistoryUseCase;
  Function getWalletHistoryOnComplete;
  Function getWalletHistoryOnError;
  Function getWalletHistoryOnNext;

  WalletPresenter(
      AuthenticationRepository authRepo, WalletRepository walletRepository)
      : _getWalletHistoryUseCase = GetWalletHistoryUseCase(walletRepository),
        super(authRepo){
 //   fetchHistory();
  }

  fetchHistory(){
    _getWalletHistoryUseCase.execute(_GetWalletHistoryObserver(this));
  }

  @override
  void dispose() {
    _getWalletHistoryUseCase.dispose();
    super.dispose();
  }
}


class _GetWalletHistoryObserver extends Observer<WalletHistoryResponse>{
  final WalletPresenter _walletPresenter;


  _GetWalletHistoryObserver(this._walletPresenter);

  @override
  void onComplete() {
    assert(_walletPresenter.getWalletHistoryOnComplete != null);
    _walletPresenter.getWalletHistoryOnComplete();
  }

  @override
  void onError(e) {
    assert(_walletPresenter.getWalletHistoryOnError != null);
    _walletPresenter.getWalletHistoryOnError(e);
  }

  @override
  void onNext(WalletHistoryResponse response) {
    assert(_walletPresenter.getWalletHistoryOnNext != null);
    _walletPresenter.getWalletHistoryOnNext(response);
  }

}



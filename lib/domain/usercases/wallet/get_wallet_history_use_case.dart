import 'dart:async';

import 'package:coupon_app/domain/entities/models/WalletHistoryResponse.dart';
import 'package:coupon_app/domain/repositories/wallet_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetWalletHistoryUseCase extends CompletableUseCase<void>{
  final WalletRepository _repository;


  GetWalletHistoryUseCase(this._repository);

  @override
  Future<Stream<WalletHistoryResponse>> buildUseCaseStream(params) async {
    StreamController<WalletHistoryResponse> controller = new StreamController();
    try{
      WalletHistoryResponse response = await _repository.walletHistory();
      controller.add(response);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}

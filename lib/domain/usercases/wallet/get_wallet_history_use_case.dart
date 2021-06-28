import 'dart:async';
import 'dart:ffi';

import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/entities/models/WalletTransaction.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/repositories/wallet_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetWalletHistoryUseCase extends CompletableUseCase<void>{
  final WalletRepository _repository;


  GetWalletHistoryUseCase(this._repository);

  @override
  Future<Stream<List<WalletTransaction>>> buildUseCaseStream(params) async {
    StreamController<List<WalletTransaction>> controller = new StreamController();
    try{
      List<WalletTransaction> response = await _repository.walletHistory();
      controller.add(response);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}

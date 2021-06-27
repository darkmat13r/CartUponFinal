import 'dart:async';

import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/repositories/wallet_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddToWalletUseCase extends CompletableUseCase<String>{
  final WalletRepository _repository;


  AddToWalletUseCase(this._repository);

  @override
  Future<Stream<PlaceOrderResponse>> buildUseCaseStream(String amount) async {
    StreamController<PlaceOrderResponse> controller = new StreamController();
    try{
      PlaceOrderResponse response = await _repository.addMoneyToWallet(amount);
      controller.add(response);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}

class AddToWalletParams{
  String amount;

}
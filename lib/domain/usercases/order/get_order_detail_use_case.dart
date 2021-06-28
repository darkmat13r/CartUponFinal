import 'dart:async';

import 'package:coupon_app/domain/entities/models/OrderDetailResponse.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetOrderDetailUseCase extends CompletableUseCase<String>{
  final OrderRepository _repository;


  GetOrderDetailUseCase(this._repository);
  @override
  Future<Stream<void>> buildUseCaseStream(String params) async{
    StreamController<OrderDetailResponse> controller = new StreamController();
    try{
      OrderDetailResponse orderDetailsResponse = await _repository.getOrder(params);
      controller.add(orderDetailsResponse);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}
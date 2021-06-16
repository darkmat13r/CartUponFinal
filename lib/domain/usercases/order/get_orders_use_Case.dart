import 'dart:async';

import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetOrdersUseCase extends CompletableUseCase<String>{
  final OrderRepository _repository;


  GetOrdersUseCase(this._repository);

  @override
  Future<Stream<List<Order>>> buildUseCaseStream(String params) async {
    StreamController<List<Order>> controller = new StreamController();
    try{
      List<Order> orders = await _repository.getOrders(params);
      controller.add(orders);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}
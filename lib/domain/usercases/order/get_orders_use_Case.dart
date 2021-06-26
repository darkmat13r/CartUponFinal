import 'dart:async';

import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/entities/models/OrderDetail.dart';
import 'package:coupon_app/domain/repositories/coutry_repository.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetOrdersUseCase extends CompletableUseCase<String>{
  final OrderRepository _repository;


  GetOrdersUseCase(this._repository);

  @override
  Future<Stream<List<OrderDetail>>> buildUseCaseStream(String params) async {
    StreamController<List<OrderDetail>> controller = new StreamController();
    try{
      List<OrderDetail> orders = await _repository.getOrders(params);
      controller.add(orders);
      controller.close();
    }catch(e){
      controller.addError(e);
    }
    return controller.stream;
  }

}
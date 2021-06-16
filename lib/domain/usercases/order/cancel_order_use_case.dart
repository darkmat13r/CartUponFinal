import 'dart:async';

import 'package:coupon_app/domain/entities/models/OrderCancelResponse.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class CancelOrderUseCase extends CompletableUseCase<String> {
  final OrderRepository _repository;

  CancelOrderUseCase(this._repository);

  @override
  Future<Stream<CancelOrderResponse>> buildUseCaseStream(String params) async {
    StreamController<CancelOrderResponse> controller = new StreamController();
    try {
      CancelOrderResponse data = await _repository.cancelOrder(params);
      controller.add(data);
      controller.close();
    } catch (e) {
      Logger().e(e);
      controller.addError(e);
    }
    return controller.stream;
  }
}



import 'dart:async';

import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class PlaceOrderUseCase extends CompletableUseCase<PlaceOrderParams> {
  final OrderRepository _repository;

  PlaceOrderUseCase(this._repository);

  @override
  Future<Stream<dynamic>> buildUseCaseStream(PlaceOrderParams params) async {
    StreamController<dynamic> controller = new StreamController();
    try {
      dynamic data = await _repository.placeOrder(
          shippingAddressId: params.shippingAddress,
          billingAddress: params.billingAddress,
          payMode: params.payMode,
          currencyCode: "KWD");
      controller.add(data);
      controller.close();
    } catch (e) {
      controller.addError(e);
    }
    return controller.stream;
  }
}

class PlaceOrderParams {
  String shippingAddress;
  String billingAddress;
  String payMode;
  String currencyCode;

  PlaceOrderParams(
      {@required this.shippingAddress,
      @required this.billingAddress,
      @required this.payMode,
      this.currencyCode});
}

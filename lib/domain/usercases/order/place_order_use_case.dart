import 'dart:async';

import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:logger/logger.dart';

class PlaceOrderUseCase extends CompletableUseCase<PlaceOrderParams> {
  final OrderRepository _repository;

  PlaceOrderUseCase(this._repository);

  @override
  Future<Stream<PlaceOrderResponse>> buildUseCaseStream(PlaceOrderParams params) async {
    StreamController<PlaceOrderResponse> controller = new StreamController();
    try {
      PlaceOrderResponse data = await _repository.placeOrder(
          shippingAddressId: params.shippingAddress,
          billingAddress: params.billingAddress,
          payMode: params.payMode,
          isGuest: params.isGuest,
          address: params.address,
          currencyCode: "KWD");
      controller.add(data);
      controller.close();
    } catch (e) {
      Logger().e(e);
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
  bool isGuest;
  Address address;

  PlaceOrderParams(
      {@required this.shippingAddress,
      @required this.billingAddress,
      @required this.payMode,
      this.isGuest,
      this.address,
      this.currencyCode});
}

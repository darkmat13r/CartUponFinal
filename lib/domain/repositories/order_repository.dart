import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/entities/models/OrderCancelResponse.dart';
import 'package:coupon_app/domain/entities/models/OrderDetail.dart';
import 'package:coupon_app/domain/entities/models/OrderDetailResponse.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:flutter/cupertino.dart';

abstract class OrderRepository {
  Future<PlaceOrderResponse> placeOrder(
      {@required String shippingAddressId,
      @required String billingAddress,
      @required String payMode, bool isGuest,
        Address address,
      String currencyCode});

  Future<List<OrderDetail>> getOrders(String status);
  Future<OrderDetailResponse> getOrder(String orderId);

  Future<CancelOrderResponse> cancelOrder(String orderId);
}

import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/entities/models/OrderCancelResponse.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:flutter/cupertino.dart';

abstract class OrderRepository{
  Future<PlaceOrderResponse> placeOrder({@required String shippingAddressId, @required  String billingAddress, @required String payMode , String currencyCode });
  Future<List<Order>> getOrders(String status);
  Future<CancelOrderResponse> cancelOrder(String orderId);
}
import 'package:flutter/cupertino.dart';

abstract class OrderRepository{
  Future<dynamic> placeOrder({@required String shippingAddressId, @required  String billingAddress, @required String payMode , String currencyCode });
}
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/entities/models/OrderCancelResponse.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:logger/logger.dart';

class DataOrderRepository extends OrderRepository{
  static DataOrderRepository _instance =
  DataOrderRepository._internal();
  Logger _logger;

  // Constructors
  DataOrderRepository._internal() {
    _logger = Logger();
  }

  factory DataOrderRepository() => _instance;
  @override
  Future<PlaceOrderResponse> placeOrder({String shippingAddressId, String billingAddress, String payMode, String currencyCode}) async {
    try{
      dynamic data = await HttpHelper.invokeHttp(Constants.orderCreateRoute, RequestType.post, body: {
        'shipping_address' : shippingAddressId,
        'billing_address' : shippingAddressId,
        'pay_mode' : payMode,
        'CurrencyCode' : currencyCode,
      });
      return PlaceOrderResponse.fromJson(data);
    }catch(e){
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<List<Order>> getOrders(String status) async{
    try{
      var url = Constants.createUriWithParams(Constants.orderRoute,
          {

          });
      List<dynamic> data = await HttpHelper.invokeHttp(Constants.orderRoute, RequestType.get, body: {
        "status" : status,
        'lang': Config().getLanguageId().toString(),
      });
      List<Order> response = data.map((e) => Order.fromJson(e)).toList();
      return response;
    }catch(e){
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<CancelOrderResponse> cancelOrder(String orderId) async{
    try{
      var headers = {
        'Content-Type' : 'application/x-www-form-urlencoded'
      };
      dynamic data = await HttpHelper.invokeHttp(Constants.orderCancelRoute, RequestType.get, body: {
        "order_id" : orderId
      }, headers: headers);

      CancelOrderResponse response = CancelOrderResponse.fromJson(data);
      return response;
    }catch(e){
      _logger.e(e);
      rethrow;
    }
  }



}
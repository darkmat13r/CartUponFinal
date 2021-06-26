import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/entities/models/OrderCancelResponse.dart';
import 'package:coupon_app/domain/entities/models/OrderDetail.dart';
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
  Future<List<OrderDetail>> getOrders(String status) async{
    try{
      var url = Constants.createUriWithParams(Constants.orderRoute,
          {

          });
      List<dynamic> data = await HttpHelper.invokeHttp(Constants.orderRoute, RequestType.get, body: {
        "status" : status,
        'lang': Config().getLanguageId().toString(),
      });
      List<OrderDetail> response = data.map((e) => OrderDetail.fromJson(e)).toList();
      return response;
    }catch(e){
      _logger.e(e.stackTrace);
      rethrow;
    }
  }

  @override
  Future<CancelOrderResponse> cancelOrder(String orderId) async{
    try{
      dynamic data = await HttpHelper.invokeHttp(Constants.orderCancelRoute, RequestType.get, body: {
        "item_id" : orderId
      });
      CancelOrderResponse response = CancelOrderResponse.fromJson(data);
      return response;
    }catch(e){
      _logger.e(e.stackTrace);
      rethrow;
    }
  }



}
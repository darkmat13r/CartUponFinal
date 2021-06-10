import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
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
  Future placeOrder({String shippingAddressId, String billingAddress, String payMode, String currencyCode}) async {
    try{
      dynamic data = await HttpHelper.invokeHttp(Constants.orderCreate, RequestType.get);
      dynamic response = data;
      return response;
    }catch(e){
      _logger.e(e);
      rethrow;
    }
  }



}
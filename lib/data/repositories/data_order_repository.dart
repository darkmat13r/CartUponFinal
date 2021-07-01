import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/Address.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/Order.dart';
import 'package:coupon_app/domain/entities/models/OrderCancelResponse.dart';
import 'package:coupon_app/domain/entities/models/OrderDetail.dart';
import 'package:coupon_app/domain/entities/models/OrderDetailResponse.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/repositories/order_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:logger/logger.dart';

class DataOrderRepository extends OrderRepository {
  static DataOrderRepository _instance = DataOrderRepository._internal();
  Logger _logger;

  // Constructors
  DataOrderRepository._internal() {
    _logger = Logger();
  }

  factory DataOrderRepository() => _instance;

  @override
  Future<PlaceOrderResponse> placeOrder(
      {String shippingAddressId,
      String billingAddress,
      String payMode,
      String currencyCode,
      bool isGuest,
      bool useWallet,
      Address address}) async {
    try {
      String userId = await SessionHelper().getUserId();
      Country country = await SessionHelper().getSelectedCountry();
      var body = Map<String, String>();
      _logger.e(isGuest ?? false);
      if (isGuest ?? false) {
        body = {
          'guest': "true",
          'first_name': address.first_name,
          'last_name': address.last_name,
          'username': "${address.countryCode}${address.phone_no}",
          'phone_no': "${address.countryCode}${address.phone_no}",
          'password': "Z8yNSEsdac77HeWU",
          'confirm_password': 'Z8yNSEsdac77HeWU',
          'email': address.email,
          'area': address.area != null ? address.area.id.toString() : "",
          'block': address.block != null ? address.block.id.toString() : "",
          'building': address.building,
          'floor_flat': address.floor_flat,
          'address': address.address,
          'user_sessid': userId.toString(),
          'pay_mode': payMode,
          "CurrencyCode": country != null ? country.country_currency : "KWD",
        };
      } else {
        body = {
          'shipping_address': shippingAddressId,
          'billing_address': shippingAddressId,
          'pay_mode': payMode,
          'wallet' : useWallet.toString(),
          "CurrencyCode": country != null ? country.country_currency : "KWD",
        };
      }
      dynamic data = await HttpHelper.invokeHttp(
          isGuest
              ? Constants.orderGuestCreateRoute
              : Constants.orderCreateRoute,
          RequestType.post,
          body: body);
      return PlaceOrderResponse.fromJson(data);
    } catch (e) {
      _logger.e(e);
      rethrow;
    }
  }

  @override
  Future<List<OrderDetail>> getOrders(String status) async {
    try {
      var url = Constants.createUriWithParams(Constants.orderRoute, {
        "status": status,
        'lang': Config().getLanguageId().toString(),
      });
      List<dynamic> data = await HttpHelper.invokeHttp(url, RequestType.get);
      List<OrderDetail> response =
          data.map((e) => OrderDetail.fromJson(e)).toList();
      return response;
    } catch (e) {
      _logger.e(e.stackTrace);
      rethrow;
    }
  }

  @override
  Future<CancelOrderResponse> cancelOrder(String orderId) async {
    try {
      dynamic data = await HttpHelper.invokeHttp(
          Constants.orderCancelRoute, RequestType.post,
          body: {"item_id": orderId});
      CancelOrderResponse response = CancelOrderResponse.fromJson(data);
      return response;
    } catch (e) {
      _logger.e(e.stackTrace);
      rethrow;
    }
  }

  @override
  Future<OrderDetailResponse> getOrder(String orderId) async {
    try {
      var url = Constants.createUriWithParams(Constants.orderDetailRoute, {
        "oid": orderId,
        "lang": Config().getLanguageId().toString(),
      });
      dynamic data = await HttpHelper.invokeHttp(url, RequestType.get);
      OrderDetailResponse response = OrderDetailResponse.fromJson(data);
      return response;
    } catch (e) {
      _logger.e(e.stackTrace);
      rethrow;
    }
  }
}

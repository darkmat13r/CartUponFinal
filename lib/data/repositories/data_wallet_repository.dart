import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/entities/models/WalletTransaction.dart';
import 'package:coupon_app/domain/repositories/wallet_repository.dart';
import 'package:coupon_app/domain/utils/session_helper.dart';
import 'package:logger/logger.dart';

class DataWalletRepository extends WalletRepository{
  static DataWalletRepository instance = DataWalletRepository._internal();

  Logger _logger;

  DataWalletRepository._internal() {
    _logger = Logger();
  }

  factory DataWalletRepository() => instance;

  @override
  Future<PlaceOrderResponse> addMoneyToWallet(String amount) async {
    Country country = await SessionHelper().getSelectedCountry();
    try {
      Map<String, dynamic> response = await HttpHelper.invokeHttp(
          Constants.walletRequestRoute, RequestType.post,
          body: {
            "amount": amount,
            "CurrencyCode": country != null ? country.country_currency : "KWD"});
      PlaceOrderResponse  item = PlaceOrderResponse.fromJson(response);
      return item;
    } catch (e) {
      _logger.e(e.stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<WalletTransaction>> walletHistory() async{
    try {
      List<dynamic> response = await HttpHelper.invokeHttp(
          Constants.walletRequestRoute, RequestType.get);
      List<WalletTransaction>  item = response.map((e) => WalletTransaction.fromJson(e)).toList();
      return item;
    } catch (e) {
      _logger.e(e.stackTrace);
      rethrow;
    }
  }
}
import 'package:coupon_app/app/utils/config.dart';
import 'package:coupon_app/data/utils/constants.dart';
import 'package:coupon_app/data/utils/http_helper.dart';
import 'package:coupon_app/domain/entities/models/Country.dart';
import 'package:coupon_app/domain/entities/models/PaymentOrder.dart';
import 'package:coupon_app/domain/entities/models/WalletHistoryResponse.dart';
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
    Country country = Config().selectedCountry != null ? Config().selectedCountry :  await SessionHelper().getSelectedCountry();
    try {
      Map<String, dynamic> response = await HttpHelper.invokeHttp(
          Constants.walletRequestRoute, RequestType.post,
          body: {
            "amount": amount,
            "country":  country.id.toString(),
            "CurrencyCode": country != null ? country.country_currency_symbol : "KWD"});
      PlaceOrderResponse  item = PlaceOrderResponse.fromJson(response);
      return item;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WalletHistoryResponse> walletHistory() async{
    try {
      var url = Constants.createUriWithParams(Constants.walletHistoryRoute,
          {
            "country":  Config().selectedCountry.id.toString(),
          });
      dynamic response = await HttpHelper.invokeHttp(
          url , RequestType.get);
      WalletHistoryResponse  item =WalletHistoryResponse.fromJson(response);
      return item;
    } catch (e) {
      _logger.e(e.stackTrace);
      rethrow;
    }
  }
}